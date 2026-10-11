parent(john, mary).
parent(mary, ann).

grandparent(X, Y) :- parent(X, Z), parent(Z, Y).