:-consult(ai).



playablePieces([21,21]).
testplayablePieces([2,2]).


%getPlayerPieceN(Board,Column,Row,Player,Number)
getPlayerPieceN([H|T],1,N):- 
        playerOnePiece([H|T]),!,N is H;
        N is 0.


getPlayerPieceN([H|T],2,N):- 
        playerTwoPiece([H|T]),!,N is H;
        N is 0.

boardgame([[[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]],
          [[0,v],[3,p],[3,b],[3,b],[3,p],[3,b],[0,v]],
          [[0,v],[3,b],[3,p],[0,v],[3,b],[3,p],[0,v]],
          [[0,v],[3,p],[3,b],[3,p],[3,p],[3,b],[0,v]],
          [[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]]]).

%testboardgame([[[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]],
%          [[0,v],[1,p],[1,b],[1,p],[2,b],[1,p],[0,v]],
%          [[0,v],[1,b],[1,p],[0,v],[2,p],[1,b],[0,v]],
%%          [[0,v],[1,p],[1,b],[1,p],[2,b],[1,p],[0,v]],
  %        [[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]]]).

testboardgame([[[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]],
          [[0,v],[1,p],[1,b],[0,v],[0,v],[0,v],[0,v]],
        [[0,v],[1,b],[1,p],[0,v],[0,v],[0,v],[0,v]],
        [[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]],

          [[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]]]).



startPvP:- boardgame(B),playablePieces(P), playerMenu(1,B,P).
startPvAI(D):- boardgame(B),playablePieces(P), playerMenuvAI(1,B,P,D).
startAIvP(D):- boardgame(B),playablePieces(P), playerMenuvAI2(1,B,P,D).
startAIvAI(D1 ,D2):-boardgame(B),playablePieces(P),playerMenuAIvAI(1,B,P,D1,D2).

test:-testboardgame(B),testplayablePieces(P), playerMenu(1,B,P).
       
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





%action menu: it's the menu for each action the player can do (1 - Move, 2 - Merge, 3 - Exit)
%actionMenu(Action,Board,rEsult,Player) pIeces   new pIeces
actionMenu('1',B,E,P,I,I):- 
     %   C =:= '1',
        nl,write('In which column is the piece that you want to move?'),nl,get_char(C),get_char(_),nl,number_chars(CN,[C]),
        write('In which row is the piece that you want to move?'),nl,get_char(R),get_char(_),nl,number_chars(RN,[R]),
        write('In which direction?'),
        nl,write('1 - Up'),
        nl,write('2 - Down'),
        nl,write('3 - Left'),
        nl,write('4 - Right'),
        nl,write('5 - Up Left'),
        nl,write('6 - Down Left'),
        nl,write('7 - Up Right'),
        nl,write('8 - Down Right'), nl, 
        nl,get_char(D),number_chars(DN,[D]),
        get_char(_),!,move(B,CN,RN,DN,E,P).
       
actionMenu('2',B,E,P,I,I):- 
     %   C =:= '1',
        nl,write('The resulting piece will stay in the first chosen piece'),
        nl,write('In which column is the first piece that you want to merge?'),nl,get_char(C1),get_char(_),nl,number_chars(C1N,[C1]),
        write('In which row is the first piece that you want to merge?'),nl,get_char(R1),get_char(_),nl,number_chars(R1N,[R1]),
        nl,write('In which column is the second piece that you want to merge?'),nl,get_char(C2),get_char(_),nl,number_chars(C2N,[C2]),
        write('In which row is the second piece that you want to merge?'),nl,get_char(R2),get_char(_),nl,number_chars(R2N,[R2]),
        
        merge(B,C1N,C2N,R1N,R2N,P,E).
       

actionMenu('3',B,E,P,I,NI):- 
     %   C =:= '1',
        nl,write('In which column is the piece that you want to make it exit?'),nl,get_char(C),get_char(_),nl,number_chars(CN,[C]),
        write('In which row is the piece that you want to make it exit?'),nl,get_char(R),get_char(_),nl,number_chars(RN,[R]),
        write('In which direction do you want to make it exit?'),nl,
        nl,write('1 - Up'),
        nl,write('2 - Down'),
        nl,write('3 - Left'),
        nl,write('4 - Right'),
        nl,write('5 - Up Left'),
        nl,write('6 - Down Left'),
        nl,write('7 - Up Right'),
        nl,write('8 - Down Right'),  nl,      
        get_char(D),get_char(_),nl,number_chars(DN,[D]),        
        exit(B,CN,RN,DN,P,I,E,NI).
        


gameOver(1,[H|_]):- 
        H < 2, write('PLAYER 1 WINS'),nl.


gameOver(2,[_|T]):- 
        T < 2, write('PLAYER 2 WINS'),nl.



%actionMenu(_,_,_,_):- nl,write('ERROR IN ACTION MENU FUNC').

%playerMenu  ------------- the player selects which action to take
%playerMenu(Player,Board,Pieces)   E - temporary board
playerMenu(_,B,P):-  printboard(B),nl,gameOver(1,P);
                   printboard(B),nl,gameOver(2,P).     
            
playerMenu(1,B,P):-  
        %%DEBUG%%
        write(P),nl,
        %%DEBUG%%
        printboard(B),nl,
        write('PLAYER 1'),nl,
        write('Which action will you take?'),nl,
        write('1 - Move'),nl,
        write('2 - Merge'),nl,
        write('3 - Exit'),nl,
        get_char(C),get_char(_),
        actionMenu(C,B,E,1,P,NP),playerMenu(2,E,NP);
        write('INVALID MOVE'),nl,playerMenu(1,B,P).


playerMenu(2,B,P):-  printboard(B),nl,
        write('PLAYER 2'),nl,
        write('Which action will you take?'),nl,
        write('1 - Move'),nl,
        write('2 - Merge'),nl,
        write('3 - Exit'),nl,
        get_char(C),get_char(_),
        actionMenu(C,B,E,2,P,NP),playerMenu(1,E,NP);
        write('INVALID MOVE'),nl, playerMenu(2,B,P).


playerMenu(_,_,_):- write('ERROR IN PLAYERMENU FUNC').

playerMenuvAI(_,B,P,_):- gameOver(1,P),printboard(B),nl;
                  gameOver(2,P),printboard(B),nl.     


playerMenuvAI(1,B,P,D):-  
        %%DEBUG%%
        write(P),nl,
        %%DEBUG%%
        printboard(B),nl,
        write('PLAYER 1'),nl,
        write('Which action will you take?'),nl,
        write('1 - Move'),nl,
        write('2 - Merge'),nl,
        write('3 - Exit'),nl,
        get_char(C),get_char(_),
        actionMenu(C,B,E,1,P,NP),playerMenuvAI(2,E,NP,D);
        write('INVALID MOVE'),nl,playerMenuvAI(1,B,P,D).

playerMenuvAI(2,B,P,D):-  
        aiRandomGameOp(D,B,P,2,E,NP),playerMenuvAI(1,E,NP,D);
        nl,playerMenuvAI(2,B,P,D).



playerMenuvAI2(_,B,P,_):-  gameOver(1,P),printboard(B),nl;
                  gameOver(2,P),printboard(B),nl.     

playerMenuvAI2(2,B,P,D):-  
        %%DEBUG%%
        write('[P1 PIECES, P2 PIECES]'),nl,
        write(P),nl,
        %%DEBUG%%
        printboard(B),nl,
        write('PLAYER 2'),nl,
        write('Which action will you take?'),nl,
        write('1 - Move'),nl,
        write('2 - Merge'),nl,
        write('3 - Exit'),nl,
        get_char(C),get_char(_),
        actionMenu(C,B,E,2,P,NP),playerMenuvAI2(1,E,NP,D);
        write('INVALID MOVE'),nl,playerMenuvAI2(2,B,P,D).

playerMenuvAI2(1,B,P,D):-  
        aiRandomGameOp(D,B,P,1,E,NP),playerMenuvAI2(2,E,NP,D);
        nl,playerMenuvAI2(1,B,P,D).

playerMenuAIvAI(_,B,P,_,_):- gameOver(1,P),printboard(B),nl;
                   gameOver(2,P),printboard(B),nl.

playerMenuAIvAI(1,B,P,D1,D2):-  
        write('[P1 PIECES, P2 PIECES]'),nl,
        write(P),nl,
        write('Player '), write(1), nl,
        printboard(B),nl,
        aiRandomGameOp(D1,B,P,1,E,NP),playerMenuAIvAI(2,E,NP,D1,D2);
        nl,playerMenuAIvAI(1,B,P,D1,D2).

playerMenuAIvAI(2,B,P,D1,D2):-  
        write('[P1 PIECES, P2 PIECES]'),nl,
        write(P),nl,
        write('Player '), write(2), nl,
        printboard(B),nl,
        aiRandomGameOp(D2,B,P,2,E,NP),playerMenuAIvAI(1,E,NP,D1,D2);
        nl,playerMenuAIvAI(2,B,P,D1,D2).





%%DEBUG DO MOVE
debugMove(_):- boardgame(B),
              findBoardElem(B,X,4,4),replaceElemBoard(B,3,4,X,T),%move a peça
        findBoardElem(B,Y,4,3),
        replaceElemBoard(T,4,4,Y,E),
        write(Y),nl,
        write(X),nl,
        printboard(E).

burstsort:-startMenu.

startMenu:- nl,nl,write('Burstsort'),nl,nl,
        write('Which mode do you want to play?'),nl,
        write('1 - PvP'),nl,
        write('2 - PvAI (random AI)'),nl,
        write('3 - AIvP (random AI)'),nl,
        write('4 - AIvAI(random AI1 vs random AI2)'),nl,
        %write('6 - PvAI (hard AI)'),nl,
        %write('5 - AIvP (hard AI)'),nl,
        %write('7 - AIvAI(hard AI vs random AI2)'),nl,
        %write('8 - AIvAI(random AI vs hard AI2)'),nl,
        %write('9 - AIvAI(hard AI vs hard AI2)'),nl,
        get_char(C),get_char(_),
        gamemodeMenu(C).


gamemodeMenu('1'):-startPvP.
gamemodeMenu('2'):-startPvAI(1).
gamemodeMenu('3'):-startAIvP(1).
%gamemodeMenu('4'):-startPvAI(2).
%gamemodeMenu('5'):-startAIvP(2).
gamemodeMenu('4'):-startAIvAI(1,1).
%gamemodeMenu('7'):-startAIvAI(2,1).
%gamemodeMenu('8'):-startAIvAI(1,2).
%gamemodeMenu('9'):-startAIvAI(2,2).

gamemodeMenu(_):- write('INVALID MODE'),nl,startMenu.                      