

criasup(N,DS) :-     N2 is N - 1, 
    				 N1 is -1 * (N - 1), 
    				 findall(X,between(N1,N2,X),DS).

criainf(N,DI) :-     N3 is 2 * N,
    				 findall(X,between(2,N3,X),DI).

printa([],_).
printa([R|S],N) :- R1 is R - 1,
    			   R2 is N - R,
    			   forall(between(1,R1,L),write(' . ')),
    			   write(' R '), 
                   forall(between(1,R2,L),write(' . ')), 
    			   nl,
    			   printa(S,N).

apaga(X,[X|Y],Y).
apaga(A,[B|C],[B|D]) :- apaga(A,C,D).

solucao(N,S) :- 
     crialista(N,L),
     criasup(N,DS),
     criainf(N,DI),
     resolve(S,L,L,DS,DI),
     printa(S,N).

resolve([],[],_,_,_).
resolve([C|LC],[L|LL],CO,DS,DI):-
    apaga(C,CO,CO1),
    NS is L - C,
    NI is L + C,
    apaga(NS,DS,DS1),
    apaga(NI,DI,DI1),
    resolve(LC,LL,CO1,DS1,DI1).

crialista(N,[N|L]):-N > 0, N1 is N-1, crialista(N1,L).
crialista(0,[]).
