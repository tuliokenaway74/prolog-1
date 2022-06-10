pai("Rodrigo", "Luiz Felipe").
pai("Mariano", "Rodrigo").
pai("Mariano", "Marilene").
pai("Edelmo", "Micheli").
pai("Edelmo", "Gisely").
pai("Edelmo", "Kelly").
pai("Carlos", "João Carlos").
pai("Carlos", "Gabriel").
pai("Giuliano", "Marcia Eduarda").
pai("Emerson", "Sara").

mae("Micheli", "Luiz Felipe").
mae("Sonia", "Rodrigo").
mae("Sonia", "Marilene").
mae("Marcia", "Micheli").
mae("Marcia", "Gisely").
mae("Marcia", "Kelly").
mae("Marilene", "João Carlos").
mae("Marilene", "Gabriel").
mae("Gisely", "Marcia Eduarda").
mae("Gisely", "Yasmin").
mae("Kelly", "Sara").

fem(X) :- mae(X,_).
mas(X) :- pai(X,_).

avo_paterno(X,Y) :- pai(X,Z), pai(Z,Y).
avo_materno(X,Y) :- pai(X,Z), mae(Z,Y).
avoh_paterna(X,Y) :- mae(X,Z), pai(Z,Y).
avoh_materna(X,Y) :- mae(X,Z), mae(Z,Y).

irmao(X,Y) :- pai(Z,Y), pai(Z,X), X \= Y.        

tio(X,Y) :- pai(Z,Y), irmao(X,Z), mas(X).
tio(X,Y) :- mae(Z,Y), irmao(X,Z), mas(X).

tia(X,Y) :- pai(Z,Y), irmao(X,Z), fem(X).
tia(X,Y) :- mae(Z,Y), irmao(X,Z), fem(X).


primo(X,Y) :- tio(Z,X), pai(Z,Y).
primo(X,Y) :- tio(Z,X), mae(Z,Y).
