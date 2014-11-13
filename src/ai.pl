:-use_module(library(random)).
:-consult(moves).

playerOnePieces([[2,2],[5,2],[3,3],[6,3],[2,4],[4,4],[5,4]]).
playerTwoPieces([[3,2],[4,2],[6,2],[2,3],[5,3],[3,4],[6,4]]).

%aiRandomMovePicker(move)
aiRandomMovePicker(M):-random(1,4,M).

%aiRandomDirPicker(direction).
aiRandomDirPicker(D):-random(1,9,D).

%aiRandomCellPicker(column,row).
aiRandomCellPicker(C,R):-random(2,7,C),random(2,5,R).


%aiRandomGameOp(Dificulty(1 - Random 2 - Greedy,Board,Player,pIeces,rEsult,New pIeces)
aiRandomGameOp(1,B,I,P,E,NI):- aiRandomMovePicker(C),aiROp(C,B,P,I,E,NI). 

aiRandomGameOp(2,B,I,P,L,E,NI,UL):- aiOp(3,B,P,I,L,E,NI,UL);
                                    aiROp(1,B,P,I,E,NI).

%aiROp(Choice,Board,Player,pIece,rEsult,New pIece):-
aiROp(1,B,P,I,E,I):-
        aiRandomCellPicker(C,R),
        aiRandomDirPicker(D),
        move(B,C,R,D,E,P),!.
        
        

%merge
aiROp(2,B,P,I,E,I):-
          aiRandomCellPicker(C1,R1),
          aiRandomCellPicker(C2,R2),
          merge(B,C1,R1,C2,R2,E,P),!.
%exit
aiROp(3,B,P,I,E,NI):-
        aiRandomCellPicker(C,R),
        aiRandomDirPicker(D),
        exit(B,C,R,D,P,I,E,NI),!.

%greedy operations
%move(Choice,Board,Player,pIece,Pieces List,rEsult,New pIece,Update List):-

aiOp(1,B,P,I,E,I):-
        aiRandomCellPicker(C,R),
        aiRandomDirPicker(D),
        move(B,C,R,D,E,P),!.


%findUL(Player,Cell,List,Updated List)
findUL(1,X,[H|T],[H|T]):-
        playerOnePiece(X).

findUL(2,X,[H|T],[H|T]):-
        playerTwoPiece(X).


findUL(_,_,[_|T],T).

        
aiOp(3,B,_,I,[],B,I,_).

aiOp(3,B,P,I,[[C|R]|T],E,NI,UL):-
        %UP
        L is R -1,
        S is R -2,
        not(validMove(B,C,L)),!,%verifica se tem uma peça para saltar por cima
        validExitCell(B,C,S,P),!,%verifica se pode sair
        exit(B,C,R,1,P,I,E,NI),!,%faz a jogada
        findBoardElem(E,X,C,R),!,%verifica se ficou uma celula vazzio no sítio onde a peça estava
        findUL(P,X,[[C|R]|T],UL);
        %DOWN
         L is R + 1,
        S is R + 2,
        not(validMove(B,C,L)),!,%verifica se tem uma peça para saltar por cima
        validExitCell(B,C,S,P),!,%verifica se pode sair
        exit(B,C,R,2,P,I,E,NI),!,%faz a jogada
        findBoardElem(E,X,C,R),!,%verifica se ficou uma celula vazzio no sítio onde a peça estava
        findUL(P,X,[[C|R]|T],UL);
        %LEFT
        K is C -1,
        Z is C -2,
        not(validMove(B,K,R)),!,%verifica se tem uma peça para saltar por cima
        validExitCell(B,Z,R,P),!,%verifica se pode sair
        exit(B,C,R,3,P,I,E,NI),!,%faz a jogada
        findBoardElem(E,X,C,R),!,%verifica se ficou uma celula vazzio no sítio onde a peça estava
        findUL(P,X,[[C|R]|T],UL);
        %RIGHT
        K is C + 1,
        Z is C + 2,
        not(validMove(B,K,R)),!,%verifica se tem uma peça para saltar por cima
        validExitCell(B,Z,R,P),!,%verifica se pode sair
        exit(B,C,R,3,P,I,E,NI),!,%faz a jogada
        findBoardElem(E,X,C,R),!,%verifica se ficou uma celula vazzio no sítio onde a peça estava
        findUL(P,X,[[C|R]|T],UL);
        %%UP LEFT
        L is R -1,
        S is R -2,
        K is C -1 ,
        Z is C -2, 
        not(validMove(B,K,L)),!,%verifica se tem uma peça para saltar por cima
        validExitCell(B,Z,S,P),!,%verifica se pode sair
        exit(B,C,R,3,P,I,E,NI),!,%faz a jogada
        findBoardElem(E,X,C,R),!,%verifica se ficou uma celula vazzio no sítio onde a peça estava
        findUL(P,X,[[C|R]|T],UL);
        %%DOWN LEFT
        L is R +1,
        S is R +2,
        K is C -1 ,
        Z is C -2, 
        not(validMove(B,K,L)),!,%verifica se tem uma peça para saltar por cima
        validExitCell(B,Z,S,P),!,%verifica se pode sair
        exit(B,C,R,3,P,I,E,NI),!,%faz a jogada
        findBoardElem(E,X,C,R),!,%verifica se ficou uma celula vazzio no sítio onde a peça estava
        findUL(P,X,[[C|R]|T],UL);
        %%UP Right
        L is R -1,
        S is R -2,
        K is C +1 ,
        Z is C +2, 
        not(validMove(B,K,L)),!,%verifica se tem uma peça para saltar por cima
        validExitCell(B,Z,S,P),!,%verifica se pode sair
        exit(B,C,R,3,P,I,E,NI),!,%faz a jogada
        findBoardElem(E,X,C,R),!,%verifica se ficou uma celula vazzio no sítio onde a peça estava
        findUL(P,X,[[C|R]|T],UL);
        %%DOWN RIGHT
        L is R +1,
        S is R +2,
        K is C +1 ,
        Z is C +2, 
        not(validMove(B,K,L)),!,%verifica se tem uma peça para saltar por cima
        validExitCell(B,Z,S,P),!,%verifica se pode sair
        exit(B,C,R,3,P,I,E,NI),!,%faz a jogada
        findBoardElem(E,X,C,R),!,%verifica se ficou uma celula vazzio no sítio onde a peça estava
        findUL(P,X,[[C|R]|T],UL);
        %Not possible
        aiOp(3,B,P,I,T,E,NI,UL2),
        UL = [[C|R]|UL2].
                       