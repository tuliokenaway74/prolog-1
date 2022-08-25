ap([],X,X).
ap([A|B],C,[A|D]) :- ap(B,C,D).

in(A,[A|_]) :- !.
in(A,[_|B]) :- in(A,B).

% Implementacao do algoritmo de busca em largura ou profundidade
% 1 = largura
% 2 = profundidade
estrategia(2).

atingemeta([_-E|_]) :- meta(E).

busca([Caminho|_], Solucao) :- atingemeta(Caminho), !, Solucao = Caminho.
busca([Caminho|Lista], Solucao) :- 
   findall(UMAEXT, estende(Caminho,UMAEXT), EXT),
   estrategia(Tipo),
   estrategia(Tipo),
   (Tipo = 1 -> ap(Lista, EXT,  Lista1);
    Tipo = 2 -> ap(EXT, Lista, Lista1)),
   busca(Lista1, Solucao).

naorepete(_-E,C) :- not(in(_-E,C)).

estende([OperacaoX-EstadoA|Caminho], [OperacaoY-EstadoB,OperacaoX-EstadoA|Caminho]) :-
   oper(OperacaoY,EstadoA,EstadoB),
   naorepete(OperacaoY-EstadoB,Caminho).

margem([F,L,C,R], M) :-
   (F = M -> write('F'); write(' ')),
   (L = M -> write('L'); write(' ')),
   (C = M -> write('C'); write(' ')),
   (R = M -> write('R'); write(' ')).

desenha(Estado) :-
     write('    '), margem(Estado, a), write('|    |'), margem(Estado,b).

escreve([_-E]) :- write('Estado Inicial: '), write(E), nl, !.
escreve([O-E|R]) :- 
    escreve(R), 
    write('Executando: '), 
    traduz(O,T),
    write(T), write(' obtemos '), /*desenha(E),*/ write(E), nl.

resolva :-
    inicial(X), 
    busca([[raiz-X]],S), 
    write(S), nl,
    escreve(S),
    write('que é a solução do problema').

%-----------------------------------
% Especificacao do problema
%-----------------------------------

%-----------------------------------
% Jarros
%-----------------------------------

% traduz(c1, 'encher o jarro 1  ').
% traduz(c2, 'encher o jarro 2  ').
% traduz(v1, 'esvaziar o jarro 1').
% traduz(v2, 'esvaziar o jarro 2').
% traduz(12, 'despejar 1 em 2   ').
% traduz(21, 'despejar 2 em 1   ').

% inicial([0,0]).
% meta([_,2]).

% oper(c1, [X,Y], [3,Y]) :- X < 3.
% oper(c2, [X,Y], [X,4]) :- Y < 4.
% oper(v1, [X,Y], [0,Y]) :- X > 0.
% oper(v2, [X,Y], [X,0]) :- Y > 0.
% oper(12, [X,Y], [0,Y1]) :- X > 0, Y < 4, Y1 is X + Y, Y1 =< 4.
% oper(12, [X,Y], [X1,4]) :- X > 0, Y < 4, X1 is X + Y - 4, X + Y > 4.
% oper(21, [X,Y], [X1,0]) :- Y > 0, X < 3, X1 is X + Y, X1 =< 3.
% oper(21, [X,Y], [3,Y1]) :- Y > 0, X < 3, Y1 is X + Y - 3, X + Y > 3.

%----------------------------------------------------------------------------------------------------%

%-----------------------------------
% Fazendeiro
%-----------------------------------

% traduz(fa, 'fazendeiro vai sozinho   ').
% traduz(fb, 'fazendeiro volta sozinho ').
% traduz(la, 'fazendeiro leva o lobo   ').
% traduz(lb, 'fazendeiro traz o lobo   ').
% traduz(ca, 'fazendeiro leva a cabra  ').
% traduz(cb, 'fazendeiro traz a cabra  ').
% traduz(ra, 'fazendeiro leva o repolho').
% traduz(rb, 'fazendeiro traz o repolho').

% oper(fa, [a,L,C,R], [b,L,C,R]) :- L \= C, C \= R.
% oper(fb, [b,L,C,R], [a,L,C,R]) :- L \= C, C \= R.
% oper(la, [a,a,C,R], [b,b,C,R]) :- (C \= R; C = b).
% oper(lb, [b,b,C,R], [a,a,C,R]) :- (C \= R; C = a).%
% oper(ca, [a,L,a,R], [b,L,b,R]).
% oper(cb, [b,L,b,R], [a,L,a,R]).
% oper(ra, [a,L,C,a], [b,L,C,b]) :- (L \= C; C = b).
% oper(rb, [b,L,C,b], [a,L,C,a]) :- (L \= C; C = a).

% % [F,L,C,R], margem em que está cada elemento
% inicial([a,a,a,a]).
% meta([b,b,b,b]).

%----------------------------------------------------------------------------------------------------%

%-----------------------------------
% Especificacao da quarta atividade
%-----------------------------------

traduz(l1, 'leva 1 missionário e 1 canibal para a margem direita').
traduz(l2, 'leva 2 missionários para a margem direita           ').
traduz(l3, 'leva 2 canibais para a margem direita               ').
traduz(l4, 'leva 1 missionário para a margem direita            ').
traduz(l5, 'leva 1 canibal para a margem direita                ').

traduz(v1, 'volta 1 missionário e 1 canibal para a margem esquerda').
traduz(v2, 'volta 2 missionários para a margem esquerda           ').
traduz(v3, 'volta 2 canibais para a margem esquerda               ').
traduz(v4, 'volta 1 missionário para a margem esquerda            ').
traduz(v5, 'volta 1 canibal para a margem esquerda                ').

%----EstadoInicial-----------------------------------------------------------------------------------%

inicial([3,3,0]). % 3 missionarios e 3 canibais na margem esquerda com o bote na margem esquerda %

%--------Meta----------------------------------------------------------------------------------------%

meta([0,0,1]). % 0 missionarios e 0 canibais na margem esquerda com o bote na margem direita

%-----Operações--------------------------------------------------------------------------------------%

teste([M,C]) :- (M is C; M is 3; M is 0).

oper(l1, [M1,C1,0], [M2,C2,1]) :- 
    M2 is (M1-1), 
    C2 is (C1-1), 
    M1 > 0, 
    C1 > 0, 
    teste([M2,C2]).
oper(l2, [M1,C,0], [M2,C,1]) :- 
    M2 is (M1-2),
    M1 > 1,
    teste([M2,C]).
oper(l2, [M,C1,0], [M,C2,1]) :- 
    C2 is (C1-2), 
    C1 > 1,
    teste([M,C2]).
oper(l4, [M1,C,0], [M2,C,1]) :- 
    M2 is (M1-1), 
    M1 > 0, 
    teste([M2,C]).
oper(l5, [M,C1,0], [M,C2,1]) :- 
    C2 is (C1-1), 
    C1 > 0,
    teste([M,C2]).


oper(v1, [M1,C1,1], [M2,C2,0]) :- 
    M2 is (M1+1), 
    C2 is (C1+1), 
    M1 < 3, C1 < 3,
    teste([M2,C2]).
oper(v2, [M1,C,1], [M2,C,0]) :- 
    M2 is (M1+2), 
    M1 < 2,
    teste([M2,C]).
oper(v3, [M,C1,1], [M,C2,0]) :- 
    C2 is (C1+2), 
    C1 < 2, 
    teste([M,C2]).
oper(v4, [M1,C,1], [M2,C,0]) :- 
    M2 is (M1+1), 
    M1 < 3, 
    teste([M2,C]). 
oper(v5, [M,C1,1], [M,C2,0]) :-
    C2 is (C1+1), 
    C1 < 3, 
    teste([M,C2]).
