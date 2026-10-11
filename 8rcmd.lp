% ==========================================================
% 1. DOMINIO
% ==========================================================
tamano(8).
fila(1..N) :- tamano(N).
columna(1..N) :- tamano(N).

% ==========================================================
% 2. GENERATE
% Para cada fila, colocar exactamente una reina en alguna columna
% ==========================================================
1 { reina(F, C) : columna(C) } 1 :- fila(F).

% ==========================================================
% 3. CHECK (Restricciones de Integridad)
% ==========================================================
% No compartir columna
:- reina(F1, C), reina(F2, C), F1 != F2.

% No compartir diagonal principal
:- reina(F1, C1), reina(F2, C2), F1 < F2, F1 - F2 == C1 - C2.

% No compartir diagonal secundaria
:- reina(F1, C1), reina(F2, C2), F1 < F2, F1 - F2 == C2 - C1.

% ==========================================================
% 4. SHOW
% ==========================================================
#show reina/2.