%verdadero-falso
%a :- b.
%b :- a.

%verdadero-falso en 3 constantes
a :- not b.
b :- not a.
c.
:- c, not b.