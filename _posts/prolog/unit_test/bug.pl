add(2, 2, 5) :- !.
add(X, Y, Z) :- not((X is 2, Y is 2)) -> Z is Y + X.


:- begin_tests(bug).
test(add) :-
  add(2, 2, 4)
.

test(add) :-
  findall(X, add(2, 2, X), Xs),
  Xs == [4]
.

:- end_tests(bug).
