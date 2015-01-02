%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%                 Sockets                   %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:-use_module(library(sockets)).
:-consult(src).

port(60070).

% launch me in sockets mode
server:-
	port(Port),
	socket_server_open(Port, Socket),
	socket_server_accept(Socket, _Client, Stream, [type(text)]),
	write('Accepted connection'), nl,
	serverLoop(Stream),
	socket_server_close(Socket).

% wait for commands
serverLoop(Stream) :-
	repeat,
	read(Stream, ClientMsg),
	write('Received: '), write(ClientMsg), nl,
	parse_input(ClientMsg, MyReply),
	format(Stream, '~q.~n', [MyReply]),
	write('Wrote: '), write(MyReply), nl,
	flush_output(Stream),
	(ClientMsg == quit; ClientMsg == end_of_file), !.

%%move(Board,Column,Row,Direction,rEsult,Player)
parse_input(move(B,C,R,D,P), Answer):-
        move(B,C,R,D,Answer,P);
         Answer ='NO'.                                           

parse_input(comando(Arg1, Arg2), Answer) :-
	comando(Arg1, Arg2, Answer).
	
parse_input(quit, ok-bye) :- !.

parse_input(boardgame(B),Answer):-
        printboard(B),
        Answer = "board successfully received".
		
comando(Arg1, Arg2, Answer) :-
	write(Arg1), nl, write(Arg2), nl,
	Answer = 5.