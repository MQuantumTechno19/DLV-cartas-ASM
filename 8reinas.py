import clingo

def renderizar_tablero(posiciones, n=8):
    """Imprime el tablero de ajedrez en consola."""
    grid = [["." for _ in range(n)] for _ in range(n)]
    for f, c in posiciones:
        grid[f - 1][c - 1] = "Q"
    
    print("\n  " + " ".join([str(i) for i in range(1, n + 1)]))
    for i, row in enumerate(grid):
        print(f"{i + 1} " + " ".join(row))
    print()

def resolver_n_reinas(n=8):
    # 1. Crear el objeto de control de Clingo
    ctl = clingo.Control()

    # 2. Cargar el archivo de reglas ASP
    ctl.load("8reinas.lp")

    # 3. Inyectar dinámicamente el dominio (filas y columnas 1..N) mediante la API
    backend = ctl.backend()
    with backend:
        for i in range(1, n + 1):
            # Inyectar hecho: fila(i).
            sym_f = clingo.Function("fila", [clingo.Number(i)])
            atom_f = backend.add_atom(sym_f)
            backend.add_rule([atom_f])

            # Inyectar hecho: columna(i).
            sym_c = clingo.Function("columna", [clingo.Number(i)])
            atom_c = backend.add_atom(sym_c)
            backend.add_rule([atom_c])

    # 4. Realizar Grounding
    print(f"Realizando grounding para un tablero de {n}x{n}...")
    ctl.ground([("base", [])])

    # 5. Resolver y procesar modelos
    posiciones_reinas = []

    def on_model(model):
        nonlocal posiciones_reinas
        posiciones_reinas.clear()
        for symbol in model.symbols(shown=True):
            if symbol.name == "reina":
                f, c = symbol.arguments
                posiciones_reinas.append((f.number, c.number))

    print("Buscando solución...")
    result = ctl.solve(on_model=on_model)

    # 6. Mostrar resultados
    if result.satisfiable:
        print("================ SOLUCIÓN ENCONTRADA ================")
        print(f"Posiciones (Fila, Columna): {sorted(posiciones_reinas)}")
        renderizar_tablero(posiciones_reinas, n)
        print("=====================================================")
    else:
        print("No se encontró solución.")

if __name__ == "__main__":
    resolver_n_reinas(8)
