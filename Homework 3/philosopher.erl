%% @author Charlotta
%% @doc @todo Add description to philosopher.


-module(philosopher).

-compile(export_all).

start(Hungry, Right, Left, Name, Ctrl) ->
	spawn_link(fun() -> dream(Hungry, Right, Left, Name, Ctrl) end).

sleep(T,D)->
	timer:sleep(T + random:uniform(D)).

dream(Hungry, Right, Left, Name, Ctrl) ->
	sleep(200, 100),
	chopstick:request(Left),
	chopstick:request(Right),
	wait(Hungry, Right, Left, Name, Ctrl).

wait(Hungry, Right, Left, Name, Ctrl) ->
	eat(Hungry, Right, Left, Name, Ctrl).

eat(Hungry, Right, Left, Name, Ctrl)->
	sleep(200, 100),
	chopstick:return(Left),
	chopstick:return(Right),
	if 
		Hungry =< 1 ->
			Ctrl ! done;
		true ->
			%% call dream and decrement Hungry until the value reaches 1
			io:format("~s is still eating ~n", [Name]),
			dream(Hungry-1, Right, Left, Name, Ctrl)
	end.

















