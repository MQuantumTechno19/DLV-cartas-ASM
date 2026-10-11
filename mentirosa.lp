%definimos a las personas mentirosas
persona(grecia; maria; karen).

% Cada persona o dice la verdad (dice_verdad) o miente (miente), pero no ambas.
{dice_verdad(P)} 1 :- persona(P).
miente(P) :- persona(P), not dice_verdad(P).

% Cada persona es culpable o inocente, y hay exactamente un culpable.
{culpable(P)} 1 :- persona(P).

% --- DECLARACIONES DE LOS PERSONAJES ---
% Si alguien dice la verdad, lo que afirma debe ser cierto en el modelo.
% Si miente, lo que afirma debe ser falso.

% 1. grecia dice: "Yo no fui"
dice_verdad(grecia) :- not culpable(grecia).
miente(grecia) :- culpable(grecia).

% 2. maria dice: "Fue Grecia"
dice_verdad(maria) :- culpable(grecia).
miente(maria) :- not culpable(grecia).

% 3. Karen dice: "Fue maria"
dice_verdad(karen) :- culpable(maria).
miente(karen) :- not culpable(maria).

% --- RESTRICCIÓN DEL PROBLEMA ---
% Sabemos que exactamente 2 personas dicen la verdad (1 miente)

:- #count { P : dice_verdad(P) } != 2.

% Mostramos los resultados en pantalla
#show dice_verdad/1.
#show miente/1.
#show culpable/1.