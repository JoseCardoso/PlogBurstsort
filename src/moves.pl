
%facts
voidSpace([0,v]).
playerOnePiece([_,p]).
playerTwoPiece([_,b]).
midCell(4,3).
            
%not
not(Goal) :- call(Goal),!,fail.
not(_).


%find list element
%findElem(List,Position,Element)
%findElem([],_,_):- write('Error finding the element'),nl.
findElem([H|_],1,E):- E = H.
findElem([_|T],N,E):- N1 is N-1, findElem(T,N1,E).

%findBoardElem(Board,Element,Column,Row)
findBoardElem(B,E,C,R):- findElem(B,R,S), findElem(S,C,E).
%findBoardElem(_,_,_,_):- nl,write('Error in findBoradElem').


%validMove(Board,Column,Row)
validMove(B,C,R):-    
        findBoardElem(B,E,C,R),!, voidSpace(E).


%validplayerPiece(Board,Column,Row,Player)
validplayerPiece(B,C,R,1):- findBoardElem(B,E,C,R),!,playerOnePiece(E).
validplayerPiece(B,C,R,2):- findBoardElem(B,E,C,R),!,playerTwoPiece(E).


%move --------   moves the piece to another cell (if possible)
%%move(Board,Column,Row,Direction,rEsult,Player)    T - temporary board, L - new line        
move(B,C,R,1,E,P):- L is R - 1, validMove(B,C,L),!,validplayerPiece(B,C,R,P),!,%,
        not(outerCell(C,R)),!,
        not(outerCell(C,L)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,C,X,T),!,%move a peça
        findBoardElem(B,Y,C,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,2,E,P):- L is R + 1,  validMove(B,C,L),!,validplayerPiece(B,C,R,P),!, 
        not(outerCell(C,R)),!,
        not(outerCell(C,L)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,C,X,T),!,     
        findBoardElem(B,Y,C,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,3,E,P):- K is C - 1,validMove(B,K,R),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        not(outerCell(K,R)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,R,K,X,T),!,%move a peça
        findBoardElem(B,Y,K,R),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,4,E,P):- K is C + 1,validMove(B,K,R),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        not(outerCell(K,R)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,R,K,X,T),%move a peça
        findBoardElem(B,Y,K,R),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,5,E,P):- K is C - 1, L is R - 1 ,validMove(B,K,L),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        not(outerCell(K,L)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,K,X,T),%move a peça
        findBoardElem(B,Y,K,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,6,E,P):- K is C - 1, L is R + 1 ,validMove(B,K,L),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        not(outerCell(K,L)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,K,X,T),%move a peça
        findBoardElem(B,Y,K,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,7,E,P):- K is C + 1, L is R - 1 ,validMove(B,K,L),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        not(outerCell(K,L)),!,
        findBoardElem(B,X,C,R),!,replaceElemBoard(B,L,K,X,T),%move a peça
        findBoardElem(B,Y,K,L),!,replaceElemBoard(T,R,C,Y,E).%poe o sitio onde a peça estava a vazio

move(B,C,R,8,E,P):- K is C + 1, L is R + 1 ,validMove(B,K,L),!,validplayerPiece(B,C,R,P),!,     
        not(outerCell(C,R)),!,
        not(outerCell(K,L)),!,
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


