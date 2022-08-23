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
    write(T), write(' obtemos '), desenho(E), nl.

resolva :-
    inicial(X), 
    busca([[raiz-X]],S), 
    write(S), nl,
    escreve(S),
    write('que é a solução do problema').

%-----------------------------------
% Especificacao do problema
%-----------------------------------

desenho([MA,CA,MB,CB,B]) :- 
    write('    '), 
    escreve(MA,'M'), 
    escreve(CA,'C'),
    escreveRio(B),
    escreve(MB,'M'), 
    escreve(CB,'C'),
    write('    ').

escreve(Q,S) :- 
    forall(between(1,Q,X),write(S)), 
    B is 3 - Q,
    forall(between(1,B,X),write(' ')).

escreveRio(B) :- B is 0, write('|-    |').
escreveRio(B) :- B is 1, write('|    -|').


traduz(imc, '1 missionario e 1 canibal atravessam o rio').
traduz(imm, '2 missionarios atravessam o rio           ').
traduz(icc, '2 canibais atravessam o rio               ').
traduz(im,  '1 missionario atravessa o rio             ').
traduz(ic,  '1 canibal atravessa o rio                 ').

traduz(vmc, '1 missionario e 1 canibal voltam pelo rio ').
traduz(vmm, '2 missionarios voltam pelo rio            ').
traduz(vcc, '2 canibais voltam pelo rio                ').
traduz(vm, '1 missionario volta pelo rio              ').
traduz(vc, '1 canibal volta pelo rio                  ').



inicial([3,3,0,0,0]).
meta([0,0,3,3,1]).
% 1m1c,2m,2c,1c,1m

verifica([MA,CA,MB,CB,_]) :- (MA >= CA; MA is 0), (MB >= CB; MB is 0).

%operadores de ida, passa os m e c e muda a posicao do barco para outra margem
oper(imc, [MA,CA,MB,CB,B], [M1,C1,M2,C2,B1]) :-
    M1 is MA - 1,
    C1 is CA - 1,
    M2 is MB + 1,
    C2 is CB + 1,
    MA > 0,
    CA > 0,
    B is 0,
	verifica([M1,C1,M2,C2,B]),
    B1 is 1.
oper(imm, [MA,CA,MB,CB,B], [M1,CA,M2,CB,B1]) :- 
    M1 is MA - 2,
    M2 is MB + 2,
    MA > 1,
    B is 0,
    verifica([M1,CA,M2,CB,B]),
    B1 is 1.
oper(icc, [MA,CA,MB,CB,B], [MA,C1,MB,C2,B1]) :- 
    C1 is CA - 2,
    C2 is CB + 2,
    CA > 1,
    B is 0,
    verifica([MA,C1,MB,C2,B]),
    B1 is 1.
oper(im, [MA,CA,MB,CB,B], [M1,CA,M2,CB,B1]) :- 
    M1 is MA - 1,
    M2 is MB + 1,
    MA > 0,
    B is 0,
    verifica([M1,CA,M2,CB,B]),
    B1 is 1.
oper(ic, [MA,CA,MB,CB,B], [MA,C1,MB,C2,B1]) :-
    C1 is CA - 1,
    C2 is CB + 1,
    CA > 0,
    B is 0,
    verifica([MA,C1,MB,C2,B]),
    B1 is 1.

%operadores de volta volta os m e c e volta o barco para outra margem
oper(vmc, [MA,CA,MB,CB,B], [M1,C1,M2,C2,B1]) :-
    M1 is MA + 1,
    C1 is CA + 1,
    M2 is MB - 1,
    C2 is CB - 1,
    MB > 0,
    CB > 0,
    B is 1,
	verifica([M1,C1,M2,C2,B]),
    B1 is 0.
oper(vmm, [MA,CA,MB,CB,B], [M1,CA,M2,CB,B1]) :- 
    M1 is MA + 2,
    M2 is MB - 2,
    MB > 1,
    B is 1,
    verifica([M1,CA,M2,CB,B]),
    B1 is 0.
oper(vcc, [MA,CA,MB,CB,B], [MA,C1,MB,C2,B1]) :- 
    C1 is CA + 2,
    C2 is CB - 2,
    CB > 1,
    B is 1,
    verifica([MA,C1,MB,C2,B]),
    B1 is 0.
oper(vm, [MA,CA,MB,CB,B], [M1,CA,M2,CB,B1] ) :- 
    M1 is MA + 1,
    M2 is MB - 1,
    MB > 0,
    B is 1,
    verifica([M1,CA,M2,CB,B]),
    B1 is 0.
oper(vc, [MA,CA,MB,CB,B], [MA,C1,MB,C2,B1]) :-
    C1 is CA + 1,
    C2 is CB - 1,
    CB > 0,
    B is 1,
    verifica([MA,C1,MB,C2,B]),
    B1 is 0.
