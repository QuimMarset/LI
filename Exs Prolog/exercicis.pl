% Ex1:

flatten([],[]).
flatten([X|L],LF):- flatten(L,L2),flatten(X,L3),append(L3,L2,LF),!.
flatten(X,[X]).


flattenNoRepetitions(L1,L2):- flatten(L1,L3), borrarReps(L3,L2).

borrarReps([],[]).
borrarReps(L,LFR):- append(L2,[X],L), borrarReps(L2,LFR), member(X,LFR),!.
borrarReps(L,LFR):- append(L2,[X],L), borrarReps(L2,L3), append(L3,[X],LFR).


% Ex2:


compruevaRestric(Sol):- member([X,amarillo,actor,_,_,_],Sol), member([Y,_,_,caballo,_,_],Sol), X is Y-1.
compruevaRestric(Sol):- member([X,amarillo,actor,_,_,_],Sol), member([Y,_,_,caballo,_,_],Sol), X is Y+1.

compruevaRestric2(Sol):- member([X,_,medico,_,_,_],Sol), member([Y,_,_,ardilla,_,_],Sol), X is Y-1.
compruevaRestric2(Sol):- member([X,_,medico,_,_,_],Sol), member([Y,_,_,ardilla,_,_],Sol), X is Y+1.


pert_con_resto(X,L,Resto):- append(L1,[X|L2],L), append(L1,L2,Resto).


casas:-	Sol =[	[1,_,_,_,_,_],
		[2,_,_,_,_,_],
		[3,_,_,_,_,_],
		[4,_,_,_,_,_],
		[5,_,_,_,_,_] ],
       
        
        member([_,roja,_,_,_,peru], Sol),
        member([_,_,_,perro,_,francia],Sol),
        member([_,_,pintor,_,_,japon],Sol),
        member([_,_,_,_,ron,china],Sol),
        member([1,_,_,_,_,hungria],Sol),
        member([_,_,escultor,caracoles,_,_],Sol),
        member([3,_,_,_,cava,_],Sol),
        member([_,_,notario,_,whisky,_],Sol),
        member([2,azul,_,_,_,_],Sol),
        
        member([X,verde,_,_,coñac,_],Sol), member([Y,blanco,_,_,_,_],Sol), X is Y-1,
        compruevaRestric(Sol),
        compruevaRestric2(Sol),
        
	write(Sol), nl.
	
	
	
% Ex3:

instrucciones(LI):- instruccio(LI),!.
instrucciones(LI):- append(I1,[;|LI1],LI), instruccio(I1), instrucciones(LI1).


instruccio(I):- append([V1],[=|AUX],I), append([V2],AUX2,AUX), append([+],[V3],AUX2), 
                variable(V1),variable(V2),variable(V3),!.

instruccio(I):- append([if|AUX],[V1|AUX2],I),append([V2],[=],AUX),  
                append([then|LI1],[else|AUX3],AUX2), 
                append(LI2,[endif],AUX3), variable(V1), variable(V2), instrucciones(LI1), instrucciones(LI2).
                
variable(V):- V = x.
variable(V):- V = y.
variable(V):- V = z.

programa(L):- append([begin|LI],[end],L), instrucciones(LI).

