empty_queue([]).

enqueue(Element,[],[Element]).
enqueue(Element,[Head|Tail],[Head|Newtail]) :-
	enqueue(Element,Tail,Newtail).


dequeue(Element,[Element|Tail], Tail).

member_queue(Element,Queue) :- 
	member(Element,Queue).	


print_queue(Queue) :-
	empty_queue(Queue).

print_queue(Queue) :-
	dequeue(El,Queue,Rest),
	write(El),nl,
	print_queue(Rest).


opp(w,e).
opp(e,w).


%% figure out which is unsafe 

unsafe(state(Xs,Ys,Ys,_)) :- opp(Xs,Ys).
unsafe(state(Xs,_,Ys,Ys)) :- opp(Xs,Ys).



%%farmer goes alone
move(state(Xs,WP,GP,CP),state(Ys,WP,GP,CP)) :-
	opp(Xs,Ys), not(unsafe(state(Ys,WP,GP,CP))).


%% farmer goes with Wolf
move(state(Xs,Xs,GP,CP),state(Ys,Ys,GP,CP)) :-
	opp(Xs,Ys), not(unsafe(state(Ys,Ys,GP,CP))).	



%% farmer goes with Goat
move(state(Xs,WP,Xs,CP),state(Ys,WP,Ys,CP)) :-
	opp(Xs,Ys), not(unsafe(state(Ys,WP,Ys,CP))).	


%% farmer goes with Cabbage
move(state(Xs,WP,GP,Xs),state(Ys,WP,GP,Ys)) :-
	opp(Xs,Ys), not(unsafe(state(Ys,WP,GP,Ys))).	


path(Goal, Goal, Been_Queue) :-
	write("The Solution Path is: " ), nl,
	print_queue(Been_Queue).

path(Start,Goal,Been_Queue) :-
	move(Start, Next_State),
	not(member_queue(Next_State,Been_Queue)),
	enqueue(Next_State,Been_Queue,New_Been_Queue),
	path(Next_State,Goal,New_Been_Queue),!.		



go(Start_State, Goal_State) :-
	empty_queue(Empty_Been_Queue),
	enqueue(Start_State,Empty_Been_Queue,Been_Queue),
	path(Start_State,Goal_State,Been_Queue).

