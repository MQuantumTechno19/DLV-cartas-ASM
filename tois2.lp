% Generate
{ movimiento(D,P,T) : disco(D), clavija(P) } = 1 :- movimientos(M), T = 1..M.

% Define
movimiento(D,T) :- movimiento(D,_,T).
en(D,P,0) :- inicio_en(D,P).
en(D,P,T) :- movimiento(D,P,T).
en(D,P,T+1) :- en(D,P,T), not movimiento(D,T+1), not movimientos(T).
bloqueado(D-1,P,T+1) :- en(D,P,T), not movimientos(T).
bloqueado(D-1,P,T) :- bloqueado(D,P,T), disco(D).
% Test
:- movimiento(D,P,T), bloqueado(D-1,P,T).
:- movimiento(D,T), en(D,P,T-1), bloqueado(D,P,T).
:- meta_en(D,P), not en(D,P,M), movimientos(M).
:- { en(D,P,T) } != 1, disco(D), movimientos(M), T = 1..M.
% Display
#show movimiento/3.
