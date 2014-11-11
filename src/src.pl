%facts are facts and fiction's fiction
voidSpace([0,v]).
playerOnePiece([_,p]).
playerTwoPiece([_,b]).
midCell(4,3).

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



start:- boardgame(B),playablePieces(P), playerMenu(1,B,P).
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
        findBoardElem(B,E,C,R),!, voidSpace(E).


%validplayerPiece(Board,Column,Row,Player)
validplayerPiece(B,C,R,1):- findBoardElem(B,E,C,R),!,playerOnePiece(E).
validplayerPiece(B,C,R,2):- findBoardElem(B,E,C,R),!,playerTwoPiece(E).


%move --------   moves the piece to another cell (if possible)
%%move(Board,Column,Row,Direction,rEsult,Player)    T - temporary board, L - new line        
move(B,C,R,1,E,P):- L is R - 1,
        %write('yey'),!,
             
        not(outerCell(C,R)),!,
        validMove(B,C,L),!,validplayerPiece(B,C,R,P),!,%,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,C,X,T),!,%move a peça
        findBoardElem(B,Y,C,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,2,E,P):- L is R + 1,     
        not(outerCell(C,R)),!,
        %write('yey'),!,
       validMove(B,C,L),!,validplayerPiece(B,C,R,P),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,C,X,T),!,     
        not(outerCell(C,R)),!,%move a peça
        findBoardElem(B,Y,C,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,3,E,P):- K is C - 1,validMove(B,K,R),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,R,K,X,T),!,%move a peça
        findBoardElem(B,Y,K,R),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,4,E,P):- K is C + 1,validMove(B,K,R),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,R,K,X,T),%move a peça
        findBoardElem(B,Y,K,R),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,5,E,P):- K is C - 1, L is R - 1 ,validMove(B,K,L),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,K,X,T),%move a peça
        findBoardElem(B,Y,K,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,6,E,P):- K is C - 1, L is R + 1 ,validMove(B,K,L),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,K,X,T),%move a peça
        findBoardElem(B,Y,K,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,7,E,P):- K is C + 1, L is R - 1 ,validMove(B,K,L),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,K,X,T),%move a peça
        findBoardElem(B,Y,K,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,8,E,P):- K is C + 1, L is R + 1 ,validMove(B,K,L),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,K,X,T),%move a peça
        findBoardElem(B,Y,K,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio



%sameCell(Column1,Column2,Row1,Row2)
sameCell(C1,C2,R1,R2):- R1 =:= R2, C1 =:= C2.



%validMerge(Board,Column1,Column2,Row1,Row2,Player,rEsult piece)
validMerge(B,C1,C2,R1,R2,P,E):- 
        Dr is R1 - R2,
        Dc is C1 - C2,!,
        not(outerCell(C1,R1)),!,
        not(outerCell(C2,R2)),!,
        not(sameCell(C1,C2,R1,R2)),
        Dr =< 1, Dc =< 1,!,
        validplayerPiece(B,C1,R1,P),!,validplayerPiece(B,C2,R2,P),!,
        findBoardElem(B,[H1|T],C1,R1),!, findBoardElem(B,[H2|_],C2,R2),!,
        % number_chars(S1,[H1]),number_chars(S2,[H2]),
        Et is H1 + H2,!,
        Et < 4,
        E = [Et|T].
        
%merge(Board,Column1,Column2,Row1,Row2,Player,rEsult)   X - is the new piece
merge(B,C1,C2,R1,R2,P,E):- validMerge(B,C1,C2,R1,R2,P,X),!,
        replaceElemBoard(B,R1,C1,X,T),!,%põe a nova peça
        replaceElemBoard(T,R2,C2,[0,v],E).%poe o sitio onde a outra peça estava a vazio


%validExitCell(Board,column,row,player)
validExitCell(B,C,R,P):-
        validplayerPiece(B,C,R,P);
        findBoardElem(B,X,C,R),!,
        voidSpace(X).
%exitRemnants([Number of Pieces in Stack|Type],rEsult)
exitRemnants([H|T],E):-
        N is H - 1,
        N > 0,
        E = [N|T];
        E = [0,v].

%exitPiece(Player,Previous Number,rEsult)
exitPiece(1,N,E):- N1 is N + 1, E = [N1,p].
exitPiece(2,N,E):- N1 is N + 1, E = [N1,b].

%outerCell(Column,Row)
outerCell(C,R):- C =:= 1;
                 R =:= 1;
                 C =:= 7;
                 R =:= 5.
                      

% exit(Board,Column,Row,Direction,Player,rEsult) L - Célula adjacente S - Célula de Saída  X - Pilha inicial, RP - Pilha que fica em Jogo
% T - tabuleiro temporário        EP - exit piece      EC - Número de peças na célula de saída  K - Outra Célula Adjacente (coluna) Z - outra saída adjacente(Coluna)
%  I -pIeces    NI - New pIeces


%decrementPiece(Player,pIeces,rEsult)
decrementPiece(1,[H|T],[E|T]):- E is H - 1.

decrementPiece(2,[H|T],[H|E]):- E is T - 1.


exit(B,C,R,1,P,I,E,NI):- 
        not(outerCell(C,R)),!,
        not(midCell(C,R)),!,
        L is R - 1,
        S is R - 2,
        R =:= 3,!,
        validplayerPiece(B,C,R,P),!,
        not(validMove(B,C,L)),!,
        validExitCell(B,C,S,P),!,
        findBoardElem(B,X,C,R),!,
        findBoardElem(B,[EC|_],C,S),!,
        EC < 3,!,
        exitRemnants(X,RP),
        replaceElemBoard(B,R,C,RP,T),!,
        exitPiece(P,EC,EP),
        decrementPiece(P,I,NI),
        replaceElemBoard(T,S,C,EP,E).
        
exit(B,C,R,2,P,I,E,NI):-      
        not(outerCell(C,R)),!,
        not(midCell(C,R)),!,
        L is R + 1,
        S is R + 2,
        R =:= 3,!,
        validplayerPiece(B,C,R,P),!,
        not(validMove(B,C,L)),!,
        validExitCell(B,C,S,P),!,
        findBoardElem(B,X,C,R),!,
        findBoardElem(B,[EC|_],C,S),!,
        EC < 3,!,
        exitRemnants(X,RP),
        replaceElemBoard(B,R,C,RP,T),!,
        exitPiece(P,EC,EP),
        decrementPiece(P,I,NI),
        replaceElemBoard(T,S,C,EP,E).

exit(B,C,R,3,P,I,E,NI):-      
        not(outerCell(C,R)),!,
        not(midCell(C,R)),!,
        L is C - 1,
        S is C - 2,
        C =:= 3,!,
        validplayerPiece(B,C,R,P),!,
        not(validMove(B,L,R)),!,
        validExitCell(B,S,R,P),!,
        findBoardElem(B,X,C,R),!,
        findBoardElem(B,[EC|_],S,R),!,
        EC < 3,!,
        exitRemnants(X,RP),
        replaceElemBoard(B,R,C,RP,T),!,
        exitPiece(P,EC,EP),
        decrementPiece(P,I,NI),
        replaceElemBoard(T,R,S,EP,E).

exit(B,C,R,4,P,I,E,NI):-      
        not(outerCell(C,R)),!,
        not(midCell(C,R)),!,
        L is C + 1,
        S is C + 2,
        C =:= 5,!,
        validplayerPiece(B,C,R,P),!,
        not(validMove(B,L,R)),!,
        validExitCell(B,S,R,P),!,
        findBoardElem(B,X,C,R),!,
        findBoardElem(B,[EC|_],S,R),!,
        EC < 3,!,
        exitRemnants(X,RP),
        replaceElemBoard(B,R,C,RP,T),!,
        exitPiece(P,EC,EP),
        decrementPiece(P,I,NI),
        replaceElemBoard(T,R,S,EP,E).        
        
exit(B,C,R,5,P,I,E,NI):-      
        not(outerCell(C,R)),!,
        not(midCell(C,R)),!,
        L is R - 1,
        S is R - 2,
        K is C - 1,
        Z is C - 2,
        outerCell(Z,S),!,
        validplayerPiece(B,C,R,P),!,
        not(validMove(B,K,L)),!,
        validExitCell(B,Z,S,P),!,
        findBoardElem(B,X,C,R),!,
        findBoardElem(B,[EC|_],Z,S),!,
        EC < 3,!,
        exitRemnants(X,RP),
        replaceElemBoard(B,R,C,RP,T),!,
        exitPiece(P,EC,EP),
        decrementPiece(P,I,NI),
        replaceElemBoard(T,S,Z,EP,E).

exit(B,C,R,6,P,I,E,NI):-      
        not(outerCell(C,R)),!,
        not(midCell(C,R)),!,
        L is R + 1,
        S is R + 2,
        K is C - 1,
        Z is C - 2,
        outerCell(Z,S),!,
        validplayerPiece(B,C,R,P),!,
        not(validMove(B,K,L)),!,
        validExitCell(B,Z,S,P),!,
        findBoardElem(B,X,C,R),!,
        findBoardElem(B,[EC|_],Z,S),!,
        EC < 3,!,
        exitRemnants(X,RP),
        replaceElemBoard(B,R,C,RP,T),!,
        exitPiece(P,EC,EP),
        decrementPiece(P,I,NI),
        replaceElemBoard(T,S,Z,EP,E).

exit(B,C,R,7,P,I,E,NI):-      
        not(outerCell(C,R)),!,
        not(midCell(C,R)),!,
        L is R - 1,
        S is R - 2,
        K is C + 1,
        Z is C + 2,
        outerCell(Z,S),!,
        validplayerPiece(B,C,R,P),!,
        not(validMove(B,K,L)),!,
        validExitCell(B,Z,S,P),!,
        findBoardElem(B,X,C,R),!,
        findBoardElem(B,[EC|_],Z,S),!,
        EC < 3,!,
        exitRemnants(X,RP),
        replaceElemBoard(B,R,C,RP,T),!,
        exitPiece(P,EC,EP),
        decrementPiece(P,I,NI),
        replaceElemBoard(T,S,Z,EP,E).

exit(B,C,R,8,P,I,E,NI):-      
        not(outerCell(C,R)),!,
        not(midCell(C,R)),!,
        L is R + 1,
        S is R + 2,
        K is C + 1,
        Z is C + 2,
        outerCell(Z,S),!,
        validplayerPiece(B,C,R,P),!,
        not(validMove(B,K,L)),!,
        validExitCell(B,Z,S,P),!,
        findBoardElem(B,X,C,R),!,
        findBoardElem(B,[EC|_],Z,S),!,
        EC < 3,!,
        exitRemnants(X,RP),
        replaceElemBoard(B,R,C,RP,T),!,
        exitPiece(P,EC,EP),
        decrementPiece(P,I,NI),
        replaceElemBoard(T,S,Z,EP,E).



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
        nl,write('In which column is the piece that you want to make it exit now for ever?'),nl,get_char(C),get_char(_),nl,number_chars(CN,[C]),
        write('In which row is the piece that you want to make it exit now for ever?'),nl,get_char(R),get_char(_),nl,number_chars(RN,[R]),
        write('In which direction do you want to make it exit now for ever?'),nl,
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
        

%countCell(Board,Player,Column,Row,Number)  N1 - next column's number  C1 - next Column
%countCell([],_,_,_,N):- N is 0.

%countCell([H|T],P,C,R,N):-
 %      C1 is C + 1,
  %     not(outerCell(C,R)),!,
   %    getPlayerPieceN(H,P,NC),!,
   %%    countCell(T,P,C1,R,N1), 
     %  N is N1 + NC;%%%OU       
   %    C1 is C + 1,
   %    countCell(T,P,C1,R,N).
       %write('R: '),write(R),nl,
       %write('C: '),write(C),nl,
       %write(N),nl.   

%countCell([H|T],P,C,R,N):-    
 %         C1 is C + 1,
  %        C > 1, C < 7,
   %       getPlayerPieceN(H,P,NC),
    %      countCell(T,P,C1,R,N1), 
     %     N is NC + N1;
      %    N is 0.
          
          
%countRow(Board,Player,Row,Number)    R1 - next Row      N1 - next row's number
%countRow([],_,_,0).

%countRow([H|T],P,R,N):-
 %      R > 0, R < 5,
  %     countCell(H,P,2,R,NR),!,
   %    R1 is R + 1,
    %   countRow(T,P,R1,N1),!,
  %     write(R),nl,
   %    write('NR: '),write(NR),nl,
    %   write('N1: '),write(N1),nl,
  %     N is N1 + NR;
  %     N is 0.
       
      % write(N),nl.
  
       
       
       
       
%gameOver(Board,Player)    N - Number of pieces in game
%gameOver(B,1):-
%%        countRow(B,1,2,N),!,
 %     write('N: '), write(N),nl,!,
 %       N < 2,
 %       write('PLAYER 1 WINS').


%gameOver(B,2):-
 %       countRow(B,2,2,N),
  %     write('N: '),  write(N),nl,!,
   %     N < 2,
    %    write('PLAYER 2 WINS').

gameOver(1,[H|_]):- 
        H < 2, write('PLAYER 1 WINS'),nl.


gameOver(1,[_|T]):- 
        T < 2, write('PLAYER 2 WINS'),nl.



%actionMenu(_,_,_,_):- nl,write('ERROR IN ACTION MENU FUNC').

%playerMenu  ------------- the player selects which action to take
%playerMenu(Player,Board,Pieces)   E - temporary board
playerMenu(_,_,P):- gameOver(1,P);
                  gameOver(2,P).     
            
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



%%DEBUG DO MOVE
debugMove(_):- boardgame(B),
              findBoardElem(B,X,4,4),replaceElemBoard(B,3,4,X,T),%move a peça
        findBoardElem(B,Y,4,3),
        replaceElemBoard(T,4,4,Y,E),
        write(Y),nl,
        write(X),nl,
        printboard(E).