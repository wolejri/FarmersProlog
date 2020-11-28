
go(Start,Goal) :-
	empty_stack(Empty_been_stack),
	stack(Start,Empty_been_stack,Been_stack),
	path(Start,Goal,Been_stack).


%% figure out the path the farmer should take.

path(Goal, Goal, Been_stack) :-
	write('Solution path is:' ), nl,
	reverse_print_stack(Been_stack).

path(Start, Goal, Been_stack) :-
	move(Start, NextState), 
	not(member_stack(NextState,Been_stack)),
	stack(NextState,Been_stack,New_Been_stack),
	path(NextState,Goal, New_Been_stack),!.



move(state(Xs,Xs,GP,CP),state(Ys,Ys,GP,CP)) :-
	change(Xs, Ys), not(unsafe(state(Ys,Ys,GP,CP))).
	


%second move - farmer,goat	
move(state(Xs,WP,Xs,CP),state(Ys,WP,Ys,CP)) :-
	change(Xs,Ys), not(unsafe(state(Ys,WP,Ys,CP))).



%third move - farmer,cabbage
move(state(Xs,WP,GP,Xs), state(Ys,WP,GP,Ys)) :-
	change(Xs,Ys), not(unsafe(state(Ys,WP,GP,Ys))).



%fourth move - farmer only
move(state(Xs,WP,GP,CP),state(Ys,WP,GP,CP)) :-
	change(Xs,Ys), not(unsafe(state(Ys,WP,GP,CP))).



%% figure out which is unsafe 

unsafe(state(Xs,Ys,Ys,_)) :- change(Xs,Ys).
unsafe(state(Xs,_,Ys,Ys)) :- change(Xs,Ys).




%% to create an empty stack or check if stack is empty 
empty_stack([]).

%%% stack push, pull and top.
stack(Top,Stack, [Top|Stack]).


%% check if the NextState is on the stack 

member_stack(NextState,Been_stack) :-
	member(NextState,Been_stack).


%% this is for swtiching sides.
change(e,w).
change(w,e).




%% this is to printout the stack.

reverse_print_stack(S) :-
	empty_stack(S).

reverse_print_stack(S) :-
	stack(Element,Rest, S),
	reverse_print_stack(Rest),
	write(Element), nl.	




