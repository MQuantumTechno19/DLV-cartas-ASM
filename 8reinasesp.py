import random
import clingo

def renderizar_tablero(posiciones, n=8):
    """Muestra el tablero en consola."""
    grid = [["." for _ in range(n)] for _ in range(n)]
    for f, c in posiciones:
        grid[f - 1][c - 1] = "Q"
    
    print("  " + " ".join([str(i) for i in range(1, n + 1)]))
    for i, row in enumerate(grid):
        print(f"{i + 1} " + " ".join(row))

def resolver_8_reinas_aleatorio(n=8):
    # Generar una semilla aleatoria en Python
    semilla = random.randint(1, 1000000)
    
    # Configurar Clingo con heurística 100% aleatoria
    ctl = clingo.Control([
        "--rand-freq=1.0",        # Frecuencia de selecciones aleatorias (100%)
        f"--seed={semilla}"       # Semilla aleatoria
    ])

    ctl.load("8reinasesp.lp")
    ctl.ground([("base", [])])

    posiciones = []

    def on_model(model):
        nonlocal posiciones
        for symbol in model.symbols(shown=True):
            if symbol.name == "reina":
                f, c = symbol.arguments
                posiciones.append((f.number, c.number))

    # Resolver (solo buscar 1 solución)
    result = ctl.solve(on_model=on_model)

    if result.satisfiable:
        posiciones_ordenadas = sorted(posiciones)
        print(f"================ SOLUCIÓN ALEATORIA (Semilla: {semilla}) ================")
        print(f"Posiciones (Fila, Columna): {posiciones_ordenadas}\n")
        renderizar_tablero(posiciones_ordenadas, n)
        print("========================================================================\n")

if __name__ == "__main__":
    # Ejecutar para obtener una solución aleatoria diferente
    resolver_8_reinas_aleatorio()
