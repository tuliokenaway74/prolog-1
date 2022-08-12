insere(A,[B|C],[A,B|C]) :- A > B, !.
insere(A,[B|C],[B|D]) :- A =< B, insere(A,C,D).
insere(A,[],[A]).

ordemInser([A|B],Lo) :- ordemInser(B,L), insere(A,L,Lo).
ordemInser([],[]).

ap([],L,L).
ap([A|B],C,[A|D]) :- ap(B,C,D).

particao([X|L], Pivo, [X|Menores], Maiores) :- X < Pivo, !, particao(L, Pivo, Menores, Maiores).
particao([X|L], Pivo, Menores, [X|Maiores]) :- X >= Pivo, !, particao(L, Pivo, Menores, Maiores).
particao([],_,[],[]).

qSort([X|Xs], S) :-
    particao(Xs,X,Me,Ma),
    qSort(Ma, MaOrd),
    qSort(Me, MeOrd),
    ap(MaOrd, [X|MeOrd], S).
qSort([],[]).
