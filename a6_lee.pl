% Lee Robertson | CSCE 4430 | Assignment 6

% *********** IMPORTANT ***************
% To RUN this program the library "lambda" must be installed
% To COMPILE use "swipl a6_lee.pl" 
% then for output type"?- peg_game."

:- use_module(library(lambda)).
:- use_module(library(apply)).

%%%% ENTRY POINT %%%%%%% 
peg_game :-
	peg_game(Board), display(Board).
%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%% HERE WE CREATE THE BOARD %%%%%
peg_game(Board) :-
	create_game([1], [2,3,4,5,6,7,8,9,10,11,12,13,14,15], [], Board).
 
create_game(_, [_], Board_Pieces, Board) :-
	reverse(Board_Pieces, Board).
 
create_game(Free, Occupied, Board_Pieces, Board) :-
	select(S, Occupied, Oc1),
	select(O, Oc1, Oc2),
	select(E, Free, F1),
	move(S, O, E),
	create_game([S, O | F1], [E | Oc2], [move(S,O,E) | Board_Pieces], Board).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
%%%%%% CREATE ELIGIBLE MOVES FOR OUR PIECES %%%%%%%
% HERE WE SET THE NUMBER OF POSSIBLE Board FOR THE GAME BOARD
move(S,2,E) :-
	member([S,E], [[1,4], [4,1]]).
move(S,3,E) :-
	member([S,E], [[1,6], [6,1]]).
move(S,4,E):-
	member([S,E], [[2,7], [7,2]]).
move(S,5,E):-
	member([S,E], [[2,9], [9,2]]).
move(S,5,E):-
	member([S,E], [[3,8], [8,3]]).
move(S,6,E):-
	member([S,E], [[3,10], [10,3]]).
move(S,5,E):-
	member([S,E], [[4,6], [6,4]]).
move(S,7,E):-
	member([S,E], [[4,11], [11,4]]).
move(S,8,E):-
	member([S,E], [[4,13], [13,4]]).
move(S,8,E):-
	member([S,E], [[5,12], [12,5]]).
move(S,9,E):-
	member([S,E], [[5,14], [14,5]]).
move(S,9,E):-
	member([S,E], [[6,13], [13,6]]).
move(S,10,E):-
	member([S,E], [[6,15], [15,6]]).
move(S,8,E):-
	member([S,E], [[9,7], [7,9]]).
move(S,9,E):-
	member([S,E], [[10,8], [8,10]]).
move(S,12,E):-
	member([S,E], [[11,13], [13,11]]).
move(S,13,E):-
	member([S,E], [[12,14], [14,12]]).
move(S,14,E):-
	member([S,E], [[15,13], [13,15]]).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 
%%%%%%%%  HERE WE DISPLAY THE BOARD %%%%%%%%%
%%%%%%%%  DO DISPLAY THE BOARD WE USE A RECURSIVE PROCESS 
%%%%%%%%  SIMILAR TO OUR HASKELL PROGRAM

display(Piece) :-
	format("Welcome to the Cracker Barrel Peg Game ~n"),
	display(Piece, [1]).
 

display([move(S, M, E) | Tail], Free) :-
	%%%% we use the format statement to print our board (Board_Pieces) the way we want it to look
	numlist(1, 15, Board_Pieces),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1), Board_Pieces, [I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]), 
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w~n', [I11,I12,I13,I14,I15]),
	format('MOVED PIECE ~w ~n~n~n', [S]),
	select(E, Free, F1),
	display(Tail,  [S, M | F1]).

display([], Free) :-
	numlist(1, 15, Board_Pieces),
	maplist(\X^I^(member(X, Free) -> I = 0; I = 1), Board_Pieces,[I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15]),
	format('    ~w        ~n', [I1]),
	format('   ~w ~w      ~n', [I2,I3]),
	format('  ~w ~w ~w    ~n', [I4,I5,I6]),
	format(' ~w ~w ~w ~w  ~n', [I7,I8,I9,I10]),
	format('~w ~w ~w ~w ~w ~n~n', [I11,I12,I13,I14,I15]),
	format("~nTHANKS FOR PLAYING! ~n~n"),
	halt(0). 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%