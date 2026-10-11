%clingo codigo
% ==========================================================
% 1. ENTRADA DE LA RED NEURONAL (Predicciones y Penalizaciones)
% formato: pred(Posicion, Valor, CostoPenalizacion).
% Menor costo = Mayor probabilidad asignada por la red.
% ==========================================================

posicion(a; b; c).
digito(0..9).

% Posición A
pred(a, 1, 0).   % Muy probable que sea 1 (costo 0)
pred(a, 7, 5).   % Poco probable que sea 7 (costo 5)

% Posición B
pred(b, 2, 0).   % Muy probable que sea 2 (costo 0)
pred(b, 3, 8).   % Poco probable que sea 3 (costo 8)

% Posición C (La red cometió una alucinación visual)
pred(c, 8, 0).   % Cree que es 8 con alta confianza (costo 0)
pred(c, 3, 12).  % Cree muy poco probable que sea 3 (costo 12)

% ==========================================================
% 2. GENERACIÓN (Elegir exactamente 1 valor por posición)
% ==========================================================
1 { valor(Pos, V) : pred(Pos, V, _) } 1 :- posicion(Pos).

% ==========================================================
% 3. RESTRICCIÓN LÓGICA (Regla del Mundo Físico / Matemático)
% La suma de A + B DEBE ser igual a C
% ==========================================================
:- valor(a, Va), valor(b, Vb), valor(c, Vc), Va + Vb != Vc.

% ==========================================================
% 4. OPTIMIZACIÓN (Guiar al solver hacia la máxima probabilidad)
% Minimizar la suma de penalizaciones de la red neuronal
% ==========================================================
#minimize { Costo, Pos, V : valor(Pos, V), pred(Pos, V, Costo) }.

% ==========================================================
% 5. SALIDA
% ==========================================================
#show valor/2.