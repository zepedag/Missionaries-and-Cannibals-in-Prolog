% Define a predicate to check the validity of a state with X1 missionaries and X2 cannibals
valid(X1, X2) :- 
    % Conditions for a valid state:
    % - Number of missionaries on the left side (X1) must be greater than or equal to the number of cannibals (X2)
    X1 >= X2,
    % - Number of missionaries on the right side must be greater than or equal to the number of cannibals
    3 - X1 >= 3 - X2,
    % - Ensure there are at least 1 missionary and 0 cannibals on the left side
    X1 > 0,
    X2 >= 0,
    % - Ensure there are fewer than 3 missionaries and no more than 3 cannibals on the left side
    X1 < 3,
    X2 =< 3.

% Define additional cases for valid states when there are 3 missionaries on the left side
valid(3, X2) :- 
    % Ensure there are no more than 3 cannibals on the left side
    X2 >= 0,
    X2 =< 3.

% Define additional cases for valid states when there are 0 missionaries on the left side
valid(0, X2) :- 
    % Ensure there are no more than 3 cannibals on the left side
    X2 >= 0,
    X2 =< 3.

% Define possible moves of the boat (number of missionaries and cannibals moved)
move(0, 1).
move(1, 0).
move(0, 2).
move(2, 0).
move(1, 1).

% Define a predicate to check the validity of moving the boat to the right side
validmove((X1, X2), (Y1, Y2), (A, B), r) :- 
    % Select a move (A, B) from the defined moves
    move(A, B),
    % Calculate the new state (Y1, Y2) after the move
    Y1 is X1 - A,
    Y2 is X2 - B,
    % Check if the new state is valid
    valid(Y1, Y2).

% Define a predicate to check the validity of moving the boat to the left side
validmove((X1, X2), (Y1, Y2), (A, B), l) :- 
    % Select a move (A, B) from the defined moves
    move(A, B),
    % Calculate the new state (Y1, Y2) after the move
    Y1 is X1 + A,
    Y2 is X2 + B,
    % Check if the new state is valid
    valid(Y1, Y2).

% Define the possible transitions between boat directions
next(r, l).
next(l, r).

% Define the base case for finding the solution
solution(START, _, [], _, START).

% Define the recursive case for finding a solution
solution(START, DIRECTION, [(A, B)|Ss], VISITED, END) :-
    % Check if a valid move is possible from the current state (START) in the specified direction (DIRECTION)
    validmove(START, NEXT, (A, B), DIRECTION),
    % Determine the next direction for the boat movement
    next(DIRECTION, DIRECTION2),
    % Ensure that the next state (NEXT) has not been visited before
    not(member((DIRECTION2, NEXT), VISITED)),
    % Recursively find the solution starting from the next state (NEXT) with the updated direction (DIRECTION2)
    solution(NEXT, DIRECTION2, Ss, [(DIRECTION, START)|VISITED], END).
