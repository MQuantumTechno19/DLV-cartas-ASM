% ==========================================
% 1. DOMINIOS Y DEFINICIONES (1 a 5 casas)
% ==========================================
casa(1..5).

color(rojo; verde; blanco; amarillo; azul).
pais(ingles; espanol; ucraniano; noruego; japones).
mascota(perro; serpiente; zorro; caballo; cebra).
bebida(cafe; te; leche; vino; agua).
fuma(oldgold; kool; chesterfield; gitanes; craven).

% ==========================================
% 2. GENERACIÓN (Asignación Bijectiva)
% Cada casa tiene exactamente 1 atributo de cada tipo
% y cada atributo pertenece a exactamente 1 casa.
% ==========================================
1 { es_color(C, Col) : color(Col) } 1 :- casa(C).
1 { es_color(C, Col) : casa(C) } 1    :- color(Col).

1 { es_pais(C, P) : pais(P) } 1       :- casa(C).
1 { es_pais(C, P) : casa(C) } 1          :- pais(P).

1 { es_mascota(C, M) : mascota(M) } 1 :- casa(C).
1 { es_mascota(C, M) : casa(C) } 1    :- mascota(M).

1 { es_bebida(C, B) : bebida(B) } 1   :- casa(C).
1 { es_bebida(C, B) : casa(C) } 1     :- bebida(B).

1 { es_fuma(C, F) : fuma(F) } 1       :- casa(C).
1 { es_fuma(C, F) : casa(C) } 1       :- fuma(F).

% ==========================================
% 3. RESTRICCIONES (Pistas del Acertijo)
% ==========================================

% a. El inglés vive en la casa roja
:- es_pais(C, ingles), not es_color(C, rojo).

% b. El perro pertenece al español
:- es_pais(C, espanol), not es_mascota(C, perro).

% c. El de la casa verde toma café
:- es_color(C, verde), not es_bebida(C, cafe).

% d. El ucraniano toma té
:- es_pais(C, ucraniano), not es_bebida(C, te).

% e. La casa verde está inmediatamente a la derecha de la casa blanca
:- es_color(C1, verde), es_color(C2, blanco), C1 != C2 + 1.

% f. El que fuma Old Gold tiene una serpiente (víbora)
:- es_fuma(C, oldgold), not es_mascota(C, serpiente).

% g. El que fuma Kool vive en la casa amarilla
:- es_fuma(C, kool), not es_color(C, amarillo).

% h. El que toma leche vive en la casa del medio (casa 3)
:- not es_bebida(3, leche).

% i. El noruego vive en la primera casa (casa 1)
:- not es_pais(1, noruego).

% j. El que fuma Chesterfield vive al lado del que tiene un zorro
:- es_fuma(C1, chesterfield), es_mascota(C2, zorro), |C1 - C2| != 1.

% k. El que fuma Kool vive al lado del que tiene un caballo
:- es_fuma(C1, kool), es_mascota(C2, caballo), |C1 - C2| != 1.

% l. El que fuma Gitanes toma vino
:- es_fuma(C, gitanes), not es_bebida(C, vino).

% m. El japonés fuma Craven
:- es_pais(C, japones), not es_fuma(C, craven).

% n. El noruego vive al lado de la casa azul
:- es_pais(C1, noruego), es_color(C2, azul), |C1 - C2| != 1.

% ==========================================
% 4. SALIDA Y CONSULTA
% ==========================================

% Consultas solicitadas: ¿Quién tiene la cebra? ¿Quién toma agua?
dueno_cebra(P) :- es_pais(C, P), es_mascota(C, cebra).
toma_agua(P)   :- es_pais(C, P), es_bebida(C, agua).

#show dueno_cebra/1.
#show toma_agua/1.
#show es_pais/2.
#show es_color/2.
#show es_mascota/2.
#show es_bebida/2.
#show es_fuma/2.