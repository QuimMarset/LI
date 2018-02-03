% Utils:

pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).

concat([],L,L).
concat([X|L1],L2,[X|L3]):- concat(L1,L2,L3).


fact(0,1):-!.
fact(X,F):-  X1 is X - 1, fact(X1,F1), F is X * F1.

nat(0).
nat(N):- nat(N1), N is N1 + 1.

pert_con_resto(X,L,Resto):- concat(L1,[X|L2],L), concat(L1,L2,Resto).

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).


% Ex2:

prod([],1).
prod([X|L],P):- prod(L,P1), P is P1 * X.

% Ex3:

pescalar([],[],0).
pescalar([X|L1],[Y|L2],P):- pescalar(L1,L2,P1), P is P1 + (X * Y).

% Ex4:

interseccio([],_,[]).
interseccio([X|L1],L2,L3):- pert(X,L2),interseccio(L1,L2,L4), concat([X],L4,L3),!.
interseccio([_|L1],L2,L3):- interseccio(L1,L2,L3).

unio([],L,L).
unio([X|L1],L2,L3):- pert(X,L2),unio(L1,L2,L3),!.
unio([X|L1],L2,L3):- unio(L1,L2,L4),concat([X],L4,L3).

% Ex5:

ultim(L,X):- concat(_,[X],L).

invers([],[]).
invers([X|L],L1):- invers(L,L2), concat(L2,[X],L1).

% Ex6:

fib(0,0).
fib(1,1).
fib(N,F):-N > 0, N1 is N - 1, fib(N1,F1), N2 is N - 2, fib(N2,F2), F is F1 + F2.

% Ex7:

daus(0,0,[]).
daus(P,N,[X|L]):- N > 0, pert(X,[1,2,3,4,5,6]), P1 is P-X, N1 is N-1, daus(P1,N1,L).

% Ex8:

suma([],0).
suma([X|L],S):- suma(L,S1), S is S1 + X.

suma_demes(L):- pert_con_resto(X,L,R), suma(R,S), S = X, !.

% Ex9:

suma_alt(L):- concat(L1,[X|_],L), suma(L1,S), S = X, !.

% Ex10:

card([],[]).
card([X|L],[ [X,C] |L2]):- card(L,L3),pert_con_resto([X,Y],L3,L2), C is Y+1, !.
card([X|L],L2):- card(L,L3),concat([[X,1]],L3,L2).

card(L):- card(L,L2), write(L2).

% Ex11:

min([X],X).
min([X|L],M):- min(L,M1),X < M1, M = X,!.
min([_|L],M):- min(L,M).

esta_ordenada([]).
esta_ordenada([_]).
esta_ordenada([X|L]):- concat([Y],_,L),esta_ordenada(L),X =< Y.


% Ex12:

ordenacio(L1,L2):- permutacion(L1,L2), esta_ordenada(L2), !.

% Ex14:

ordenacioI([],[]).
ordenacioI([X|L1],L2):- ordenacioI(L1,L3),insercio(X,L3,L2).

insercio(X,[],[X]).
insercio(X,[Y|L1],L2):- Y >= X, concat([X],[Y|L1],L2).
insercio(X,[Y|L1],L2):- X > Y, insercio(X,L1,L3), concat([Y],L3,L2).


% Ex16:

long([],0).
long([_|L],N):-long(L,M),N is M+1.

divideix(L,L1,L2):- append(L1,L2,L), long(L1,N), long(L2,M), N = M.
divideix(L,L1,L2):- append(L1,L2,L), long(L1,N), long(L2,M), N is M + 1.


merge(L,[],L).
merge([],L,L).
merge([X|L1],[Y|L2],[X|L]):- X =< Y, merge(L1,[Y|L2],L).
merge([X|L1],[Y|L2],[Y|L]):- X > Y, merge([X|L1],L2,L).

ordenacioM([],[]).
ordenacioM([X],[X]):- !.
ordenacioM(L,LR):- divideix(L,L1,L2), ordenacioM(L1,L1M), ordenacioM(L2,L2M), merge(L1M,L2M,LR).


% Ex17:

diccionari(A,N):- nmembers(A,N,L), escriure(L), fail.

nmembers(_,0,[]).
nmembers(A,N,[X|L]):- N > 0, N1 is N-1, member(X,A), nmembers(A,N1,L).

escriure([]):- nl.
escriure([X|L]):- write(X),escriure(L).



% Ex18:

noPert(X,L):- member(X,L),!, fail.
noPert(_,_).


permutnorep(L,PA,[P|PG]):- permutacion(L,P), noPert(P,PA), permutnorep(L,[P|PA],PG).
permutnorep(_,_,[]).


palindromes(L):- permutnorep(L,[],L2),!,member(L3,L2), comprovapal(L3),write(L3),nl,fail.

comprovapal([]).
comprovapal([_]).
comprovapal([X|L]):- append(L1,[X],L),comprovapal(L1).



% Ex19:

suma([],[],[],0).
suma([X|L1],[Y|L2],[Z|L3],C):- suma(L1,L2,L3,C1), C is (X+Y+C1)//10, Z is (X+Y+C1)mod 10.

sendMoreMoney:- L = [0,1,2,3,4,5,6,7,8,9], member(M,[0,1]), pert_con_resto(M,L,L1), pert_con_resto(S,L1,L2), pert_con_resto(E,L2,L3),
                pert_con_resto(N,L3,L4), pert_con_resto(D,L4,L5), pert_con_resto(O,L5,L6), pert_con_resto(R,L6,L7), pert_con_resto(Y,L7,_),
                suma([S,E,N,D],[M,O,R,E],[O,N,E,Y],C), M = C, write('S = '), write(S), nl, write('E = '), write(E), nl, write('N = '), write(N), nl,
                write('D = '), write(D), nl, write('M = '), write(M), nl, write('O = '), write(O), nl, write('R = '), write(R), nl,
                write('Y = '), write(Y), nl, write([S,E,N,D]),write(' + '), write([M,O,R,E]), write(' = '), write([M,O,N,E,Y]), nl, fail.

