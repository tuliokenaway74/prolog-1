
insere(A,[B|C],[A,B|C]) :- A =< B, !.
insere(A,[B|C],[B|D]) :- A > B, insere(A,C,D).
insere(A,[],[A]).

ordemInser([A|B],Lo) :- ordemInser(B,L), insere(A,L,Lo).
ordemInser([],[]).

min([X],X).
min([A|B],A) :- min(B,M), A =< M, !.
min([_|B],M) :- min(B,M).

apaga(A,[A|B],B).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

removeMin(M,L,S) :- min(L,M), apaga(M,L,S), !.

ordemSelecao(L,[M|S]) :- removeMin(M,L,Li), ordemSelecao(Li,S).
ordemSelecao([],[]).

ap([],L,L).
ap([A|B],C,[A|D]) :- ap(B,C,D).

ordemTroca(L,S) :-
    ap(X,[A,B|C],L), B < A, !,
    ap(X,[B,A|C],Li),
    ordemTroca(Li,S).
ordemTroca(L,L).

particao([X|L], Pivo, [X|Menores], Maiores) :- X < Pivo, !, particao(L, Pivo, Menores, Maiores).
particao([X|L], Pivo, Menores, [X|Maiores]) :- X >= Pivo, !, particao(L, Pivo, Menores, Maiores).
particao([],_,[],[]).

qSort([X|Xs], S) :-
    particao(Xs,X,Me,Ma),
    qSort(Me, MeOrd),
    qSort(Ma, MaOrd),
    ap(MeOrd, [X|MaOrd], S).
qSort([],[]).
