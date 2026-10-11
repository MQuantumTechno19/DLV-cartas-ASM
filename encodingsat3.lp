%variable(1..4).
%clausula(1, pos(1), pos(2), neg(3)).
%clausula(2, neg(1), neg(2), pos(4)).
%clausula(3, neg(1), pos(2), neg(4)).
%clausula(4, neg(2), neg(3), neg(4)).

% ==========================================================
% 1. GENERATE
% Asignar un valor de verdad (true/false) a cada variable
% ==========================================================
1 { asignado(V, true); asignado(V, false) } 1 :- variable(V).

% ==========================================================
% 2. CHECK
% Evaluación de satisfacción de literales y cláusulas
% ==========================================================

% Definición de satisfacción de literales
sat_literal(pos(V)) :- asignado(V, true).
sat_literal(neg(V)) :- asignado(V, false).

% Una cláusula de 3 literales es satisfecha si al menos uno es verdadero
satisfecha(C) :- clausula(C, L1, L2, L3), sat_literal(L1).
satisfecha(C) :- clausula(C, L1, L2, L3), sat_literal(L2).
satisfecha(C) :- clausula(C, L1, L2, L3), sat_literal(L3).

% Identificación de cláusulas no satisfechas
no_satisfecha(C) :- clausula(C, _, _, _), not satisfecha(C).

% ==========================================================
% 3. OPTIMIZE
% Minimizar el número de cláusulas no satisfechas
% ==========================================================
#minimize { 1, C : no_satisfecha(C) }.

% ==========================================================
% 4. SHOW
% ==========================================================
%#show asignado/2.
%#show no_satisfecha/1.