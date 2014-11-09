%voidSpace 
voidSpace([0,v]).
playerOnePiece([_,p]).
playerTwoPiece([_,b]).



boardgame([[[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]],
          [[0,v],[3,p],[3,b],[3,p],[3,b],[3,p],[0,v]],
          [[0,v],[3,b],[3,p],[0,v],[3,p],[3,b],[0,v]],
          [[0,v],[3,p],[3,b],[3,p],[3,b],[3,p],[0,v]],
          [[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]]]).

testboardgame([[[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]],
          [[0,v],[1,p],[1,b],[1,p],[2,b],[1,p],[0,v]],
          [[0,v],[1,b],[1,p],[0,v],[2,p],[1,b],[0,v]],
          [[0,v],[1,p],[1,b],[1,p],[2,b],[1,p],[0,v]],
          [[0,v],[0,v],[0,v],[0,v],[0,v],[0,v],[0,v]]]).

start:- boardgame(B), playerMenu(1,B).
test:-testboardgame(B), playerMenu(1,B).
       
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

%not
not(Goal) :- call(Goal),!,fail.
not(_).


%replaceElemBoard(initial board ,row,column ,new element , result).


replaceElemBoard([H|T],1,C,E,[D|T]):-
        replace(H,C,E,D).
replaceElemBoard([H|T],R,C,E,[H|D]):-
                R1 is R-1,
                replaceElemBoard(T,R1,C,E,D).

printrow([]).
printrow([H|T]):- write('| '), write(H), write(' |'),                            
                  printrow(T).

%find list element
%findElem(List,Position,Element)
findElem([],_,_):- write('Error finding the element'),nl.
findElem([H|_],1,E):- E = H.
findElem([_|T],N,E):- N1 is N-1, findElem(T,N1,E).

%findBoardElem(Board,Element,Column,Row)
findBoardElem(B,E,C,R):- findElem(B,R,S), findElem(S,C,E).
findBoardElem(_,_,_,_):- nl,write('Error in findBoradElem').


%validMove(Board,Column,Row)
validMove(B,C,R):- 
        C < 7, C > 1, R < 5, R >1,
        findBoardElem(B,E,C,R), voidSpace(E).


%validplayerPiece(Board,Column,Row,Player)
validplayerPiece(B,C,R,1):- findBoardElem(B,E,C,R),!,playerOnePiece(E).
validplayerPiece(B,C,R,2):- findBoardElem(B,E,C,R),!,playerTwoPiece(E).


%move --------   moves the piece to another cell (if possible)
%%move(Board,Column,Row,Direction,rEsult,Player)    T - temporary board, L - new line        
move(B,C,R,1,E,P):- L is R - 1,
        %write('yey'),!,
        validMove(B,C,L),!,validplayerPiece(B,C,R,P),%,
        findBoardElem(B,X,C,R),replaceElemBoard(B,L,C,X,T),%move a peça
        findBoardElem(B,Y,C,L),replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,2,E,P):- L is R + 1,
        %write('yey'),!,
       validMove(B,C,L),!,validplayerPiece(B,C,R,P),
        findBoardElem(B,X,C,R),replaceElemBoard(B,L,C,X,T),%move a peça
        findBoardElem(B,Y,C,L),replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,3,E,P):- K is C - 1,validMove(B,K,R),!,validplayerPiece(B,C,R,P),
        findBoardElem(B,X,C,R),replaceElemBoard(B,R,K,X,T),%move a peça
        findBoardElem(B,Y,K,R),replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,4,E,P):- K is C + 1,validMove(B,K,R),!,validplayerPiece(B,C,R,P),
        findBoardElem(B,X,C,R),replaceElemBoard(B,R,K,X,T),%move a peça
        findBoardElem(B,Y,K,R),replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

        
        
%%failed        
%move(B,_,_,_,B,_):-  write('INVALID MOVE'),nl.



%sameCell(Column1,Column2,Row1,Row2)
sameCell(C1,C2,R1,R2):- R1 =:= R2, C1 =:= C2.



%validMerge(Board,Column1,Column2,Row1,Row2,Player,rEsult piece)
validMerge(B,C1,C2,R1,R2,P,E):- 
        Dr is R1 - R2,
        Dc is C1 - C2,
        not(sameCell(C1,C2,R1,R2)),
        Dr =< 1, Dc =< 1,
        validplayerPiece(B,C1,R1,P),validplayerPiece(B,C2,R2,P),
        findBoardElem(B,[H1|T],C1,R1), findBoardElem(B,[H2|_],C2,R2),
        % number_chars(S1,[H1]),number_chars(S2,[H2]),
        Et is H1 + H2,
        Et < 4,
        E = [Et|T].
        
%merge(Board,Column1,Column2,Row1,Row2,Player,rEsult)   X - is the new piece
merge(B,C1,C2,R1,R2,P,E):- validMerge(B,C1,C2,R1,R2,P,X),
        replaceElemBoard(B,R1,C1,X,T),%põe a nova peça
        replaceElemBoard(T,R2,C2,[0,v],E).%poe o sitio onde a outra peça estava a vazio


%action menu: it's the menu for each action the player can do (1 - Move, 2 - Merge, 3 - Exit)
%actionMenu(Action,Board,rEsult,Player)
actionMenu('1',B,E,P):- 
     %   C =:= '1',
        nl,write('In which column is the piece that you want to move?'),nl,get_char(C),get_char(_),nl,number_chars(CN,[C]),
        write('In which row is the piece that you want to move?'),nl,get_char(R),get_char(_),nl,number_chars(RN,[R]),
        write('In which direction?'),
        nl,write('1 - Up'),
        nl,write('2 - Down'),
        nl,write('3 - Left'),
        nl,write('4 - Right'),
        nl,get_char(D),number_chars(DN,[D]),
        get_char(_),!,move(B,CN,RN,DN,E,P).
        %write('INVALID MOVE'),nl,actionMenu('1',B,E,P).

actionMenu('2',B,E,P):- 
     %   C =:= '1',
        nl,write('The resulting piece will stay in the first chosen piece'),
        nl,write('In which column is the first piece that you want to merge?'),nl,get_char(C1),get_char(_),nl,number_chars(C1N,[C1]),
        write('In which row is the first piece that you want to merge?'),nl,get_char(R1),get_char(_),nl,number_chars(R1N,[R1]),
        nl,write('In which column is the second piece that you want to merge?'),nl,get_char(C2),get_char(_),nl,number_chars(C2N,[C2]),
        write('In which row is the second piece that you want to merge?'),nl,get_char(R2),get_char(_),nl,number_chars(R2N,[R2]),
        
        merge(B,C1N,C2N,R1N,R2N,P,E).
        %actionMenu('1',B,E,P).




%actionMenu(_,_,_,_):- nl,write('ERROR IN ACTION MENU FUNC').

%playerMenu  ------------- the player selects which action to take
%playerMenu(Player,Board)   E - temporary board
playerMenu(1,B):-  printboard(B),nl,
        write('PLAYER 1'),nl,
        write('Which action will you take?'),nl,
        write('1 - Move'),nl,
        write('2 - Merge'),nl,
        write('3 - Exit'),nl,
        get_char(C),get_char(_),
        actionMenu(C,B,E,1),playerMenu(2,E);
        write('INVALID MOVE'),nl,playerMenu(1,B).


playerMenu(2,B):-  printboard(B),nl,
        write('PLAYER 2'),nl,
        write('Which action will you take?'),nl,
        write('1 - Move'),nl,
        write('2 - Merge'),nl,
        write('3 - Exit'),nl,
        get_char(C),get_char(_),
        actionMenu(C,B,E,2),playerMenu(1,E);
        write('INVALID MOVE'),nl, playerMenu(2, B).


playerMenu(_,_):- write('ERROR IN PLAYERMENU FUNC').



%%DEBUG DO MOVE
debugMove(_):- boardgame(B),
              findBoardElem(B,X,4,4),replaceElemBoard(B,3,4,X,T),%move a peça
        findBoardElem(B,Y,4,3),
        replaceElemBoard(T,4,4,Y,E),
        write(Y),nl,
        write(X),nl,
        printboard(E).