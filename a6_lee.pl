% Lee Robertson | CSCE 4430 | Assignment 6

% ******************** IMPORTANT *****************************
% To RUN this program the library "lambda" MUST BE installed
% ************************************************************
% To COMPILE use "swipl a6_lee.pl" 
% then for output type"?- peg_game."

% OUR LIBRARIES THAT ARE USED  
:-use_module(library(lambda)).
:-use_module(library(apply)).
:-use_module(library(lists)).

%%%% ENTRY POINT %%%%%%% 
peg_game:-
	peg_game(Board).
%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%% HERE WE CREATE THE BOARD %%%%%
%%%    WE ALSO DISPLAY EACH RESULT %% 
peg_game(Board):-
	format("~nWelcome to the Cracker Barrel Peg Game ~n"),
	format("-------------------------------------- ~n"),
	format("GAME PIECES ARE REPRESENTED AS \"x\" and EMPTY SPACES ARE REPRESENTED AS \".\" ~n~n"),

	create_game([1], [2,3,4,5,6,7,8,9,10,11,12,13,14,15], [], Board),
	format("~n== Position: ~w ==~n~n", 1),
	display(Board, [1]),
	format("~n~n== FINISHED: 1 ==~n"),

	create_game([2], [1,3,4,5,6,7,8,9,10,11,12,13,14,15], [], B1),
	format("~n== Position: ~w ==~n~n", 2),
	display(B1, [2]),
	format("~n~n== FINISHED: 2 ==~n"),

	create_game([3], [1,2,4,5,6,7,8,9,10,11,12,13,14,15], [], B2),
	format("~n== Position: ~w ==~n~n", 3),
	display(B2, [3]),
	format("~n~n== FINISHED: 3 ==~n"),

	create_game([4], [1,2,3,5,6,7,8,9,10,11,12,13,14,15], [], B3),
	format("~n== Position: ~w ==~n~n", 4),
	display(B3, [4]),
	format("~n~n== FINISHED: 4 ==~n"),

	create_game([5], [1,2,3,4,6,7,8,9,10,11,12,13,14,15], [], B4),
	format("~n== Position: ~w ==~n~n", 5),
	display(B4, [5]),
	format("~n~n== FINISHED: 5 ==~n"),

	format("---------------------"),
	format("~nTHANKS FOR PLAYING! ~n~n"),
	halt(0).

%For when our board becomes empty 
create_game(_, [_], Board_Pieces, Board):-
	reverse(Board_Pieces, Board).

%here we take the Available spaces and Taken 
create_game(Available, Taken, Board_Pieces, Board):-
	select(S, Taken, Open_1),
	select(Open, Open_1, Open_2),
	select(E, Available, Front),
	create_move(S, Open, E),
	create_game([S, Open | Front], [E | Open_2], [create_move(S, Open, E) | Board_Pieces], Board).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%% CREATE ELIGIBLE create_moveS FOR OUR PIECES %%%%%%%
% HERE WE SET THE NUMBER OF POSSIBLE Board FOR THE GAME BOARD
% S is for the start piece and E is the ending piece
create_create_move(S,2,E):-
	member([S,E], [[1,4], [4,1]]).
create_move(S,3,E):-
	member([S,E], [[1,6], [6,1]]).
create_move(S,4,E):-
	member([S,E], [[2,7], [7,2]]).
create_move(S,5,E):-
	member([S,E], [[2,9], [9,2]]).
create_move(S,5,E):-
	member([S,E], [[3,8], [8,3]]).
create_move(S,6,E):-
	member([S,E], [[3,10], [10,3]]).
create_move(S,5,E):-
	member([S,E], [[4,6], [6,4]]).
create_move(S,7,E):-
	member([S,E], [[4,11], [11,4]]).
create_move(S,8,E):-
	member([S,E], [[4,13], [13,4]]).
create_move(S,8,E):-
	member([S,E], [[5,12], [12,5]]).
create_move(S,9,E):-
	member([S,E], [[5,14], [14,5]]).
create_move(S,9,E):-
	member([S,E], [[6,13], [13,6]]).
create_move(S,10,E):-
	member([S,E], [[6,15], [15,6]]).
create_move(S,8,E):-
	member([S,E], [[9,7], [7,9]]).
create_move(S,9,E):-
	member([S,E], [[10,8], [8,10]]).
create_move(S,12,E):-
	member([S,E], [[11,13], [13,11]]).
create_move(S,13,E):-
	member([S,E], [[12,14], [14,12]]).
create_move(S,14,E):-
	member([S,E], [[15,13], [13,15]]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
%%%%%%%%  HERE WE DISPLAY THE BOARD %%%%%%%%%
%%%%%%%%  DO DISPLAY THE BOARD WE USE A RECURSIVE PROCESS 
%%%%%%%%  SIMILAR TO OUR HASKELL PROGRAM

display([create_move(S, M, E) | Tail], Available) :-
	%%%% we use the format statement to print our board (Board_Pieces) the way we want it to look
	numlist(1, 15, Board_Pieces),
	maplist(\X^I^(member(X, Available) -> I = "."; I = "x"), Board_Pieces, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format("~n     ~w          ~n", [I1]), 
	format("    ~w ~w        ~n", [I2,I3]),
	format("   ~w ~w ~w      ~n", [I4,I5,I6]),
	format("  ~w ~w ~w ~w    ~n", [I7,I8,I9,I10]),
	format(" ~w ~w ~w ~w ~w  ~n", [I11,I12,I13,I14,I15]),
	select(E, Available, Front),
	display(Tail,  [S, M | Front]).

%  HERE WE SHOULD HAVE HIT THE END OF THE GAME
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display([], Available) :-
	numlist(1, 15, Board_Pieces),
	maplist(\X^I^(member(X, Available) -> I = "."; I = "x"), Board_Pieces,[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format("~n      ~w         ~n", [I1]),
	format("     ~w ~w       ~n", [I2,I3]),
	format("    ~w ~w ~w     ~n", [I4,I5,I6]),
	format("   ~w ~w ~w ~w   ~n", [I7,I8,I9,I10]),
	format("  ~w ~w ~w ~w ~w ~n~n", [I11,I12,I13,I14,I15]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%