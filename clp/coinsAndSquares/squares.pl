:- use_module(library(clpfd)).

%ejemplo(_, Big, [S1...SN]): how to fit all squares of sizes S1...SN in a square of size Big?
ejemplo(0,  3,[2,1,1,1,1,1]).
ejemplo(1,  4,[2,2,2,1,1,1,1]).
ejemplo(2,  5,[3,2,2,2,1,1,1,1]).
ejemplo(3, 19,[10,9,7,6,4,4,3,3,3,3,3,2,2,2,1,1,1,1,1,1]).
ejemplo(4,112,[50,42,37,35,33,29,27,25,24,19,18,17,16,15,11,9,8,7,6,4,2]).
ejemplo(5,175,[81,64,56,55,51,43,39,38,35,33,31,30,29,20,18,16,14,9,8,5,4,3,2,1]).


insideBigSquare(_,_,[],[]).
insideBigSquare(N,Big,[S|Sides],[V|Vars]):- V1 #= V + S - 1, V1 #>= 1, V1 #=< Big, insideBigSquare(N,Big,Sides,Vars).

comprovaOverlap(_,_,_,[],[],[]).
comprovaOverlap(S1,R1,C1,[S2|Sides],[R2|RowVars],[C2|ColVars]):- R1F #= R1 + S1 - 1, C1F #= C1 + S1 - 1,
                                                                 R2F #= R2 + S2 - 1, C2F #= C2 + S2 - 1,
                                                                 C2 #> C1F #\/ C2F #< C1 #\/ R2 #> R1F #\/ R2F #< R1,
                                                                 comprovaOverlap(S1,R1,C1,Sides,RowVars,ColVars).

nonoverlapping(1,_,_,_).
nonoverlapping(N,[S1|Sides],[R1|RowVars],[C1|ColVars]):- N > 1, N1 is N-1, comprovaOverlap(S1,R1,C1,Sides,RowVars,ColVars),
                                                         nonoverlapping(N1,Sides,RowVars,ColVars).


/*N > 1, N1 is N-1, between(1,N1,I), element(I,Sides,S2),write(I),write(N1),nl,
                                                        element(I,RowVars,R2), element(I,ColVars,C2),
                                                        R1F #= R1 + S1 - 1, C1F #= C1 + S1 - 1,
                                                        R2F #= R2 + S2 - 1, C2F #= C2 + S2 - 1,
                                                        C2 #> C1F #\/ C2F #< C1 #\/ R2 #> R1F #\/ R2F #< R1,
                                                        nonoverlapping(N1,Sides,RowVars,ColVars).*/
                                                      
main:- 
    ejemplo(3,Big,Sides),
    nl, write('Fitting all squares of size '), write(Sides), write(' into big square of size '), write(Big), nl,nl,
    length(Sides,N), 
    length(RowVars,N), % get list of N prolog vars: Row coordinates of each small square
    length(ColVars,N),
    RowVars ins 1..Big,
    ColVars ins 1..Big,
    insideBigSquare(N,Big,Sides,RowVars),
    insideBigSquare(N,Big,Sides,ColVars),
    nonoverlapping(N,Sides,RowVars,ColVars),
    append(RowVars,ColVars,Vars),
    label(Vars),
    displaySol(N,Sides,RowVars,ColVars), halt.


displaySol(N,Sides,RowVars,ColVars):- 
    between(1,N,Row), nl, between(1,N,Col),
    nth1(K,Sides,S),    
    nth1(K,RowVars,RV),    RVS is RV+S-1,     between(RV,RVS,Row),
    nth1(K,ColVars,CV),    CVS is CV+S-1,     between(CV,CVS,Col),
    writeSide(S), fail.
displaySol(_,_,_,_):- nl,nl,!.

writeSide(S):- S<10, write('  '),write(S),!.
writeSide(S):-       write(' ' ),write(S),!.

