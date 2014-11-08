boardgame([[[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]],
          [[0,v],[3,p],[3,b],[3,p],[3,b],[3,p],[0,v]],
          [[0,v],[3,b],[3,p],[0,v],[3,p],[3,b],[0,v]],
          [[0,v],[3,p],[3,b],[3,p],[3,b],[3,p],[0,v]],
          [[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]]]).

start:-boardgame(B), printboard(B).
       
       
printboard([]).
printboard([H|T]):- write(' _______  _______  _______  _______  _______  _______  _______'),nl,
                    printborder,nl,printrow(H),nl,printlowborder,nl,
                    printboard(T).
        
        
printborder:- write('| ') , write('     '), write(' |'),
        write('| ') , write('     '), write(' |'),
        write('| ') , write('     '), write(' |'),
        write('| ') , write('     '), write(' |'),
        write('| ') , write('     '), write(' |'),
        write('| ') , write('     '), write(' |'),
        write('| ') , write('     '), write(' |').


printlowborder:- write('|') , write('_______'), write('|'),
        write('|') , write('_______'), write('|'),
        write('|') , write('_______'), write('|'),
        write('|') , write('_______'), write('|'),
        write('|') , write('_______'), write('|'),
        write('|') , write('_______'), write('|'),
        write('|') , write('_______'), write('|').


before(A,B,L):- 
        append(_,[A|L1],L), 
        append(_,[B|_],L1). 

%replace([]).
%replace(E,[H|T],N,L1):- E == H,
%                        append([N|_],T,L1);
%                        replace(E,T,N,L1),
%                       append(H,L1,L1).
%replace(initial list, column , new element , result).
replace([_|T],1,E,[E|T]).
replace([H|T],N,E,[H|L]):-
        N1 is N-1,
        replace(T,N1,E,L).


%replaceElemBoard(initial board ,row,column ,new element , result).


replaceElemBoard([H|T],1,C,E,[D|T]):-
        replace(H,C,E,D).
replaceElemBoard([H|T],R,C,E,[H|D]):-
                R1 is R-1,
                replaceElemBoard(T,R1,C,E,D).

printrow([]).
printrow([H|T]):- write('| '), write(H), write(' |'),                            
                  printrow(T).


%playerMenu:
validMove(R,L,B):- 

%%move(R,L,D,B):- 
move(R,L,1,B):- S is L-1,validMove(R,S,B),  

%%failed        
move(R,L,1,B):- write('INVALID MOVE'),nl.

action(1,B):- nl,write('In which row is the piece that you want to move?'),nl,getChar(R),nl
           ,write('In which line is the piece that you want to move?'),nl,getChar(L),nl,write('In which direction?'),
            nl,write('1 - Up'),
            nl,write('2 - Down'),
            nl,write('3 - Left'),
            nl,write('4 - Right'),
            nl,getChar(D),move(R,L,D,B).

playerMenu(B):- nl,write('Which action will you take?'),nl,write('1 - Move'),nl,write('2 - Merge'),nl,write('3 - Exit'),nl,getChar(C),action(C,B).








