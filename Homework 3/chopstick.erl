%% @author Charlotta
%% @doc @todo Add description to chopstick.


-module(chopstick).

-compile(export_all).


start() ->
	spawn_link(fun() -> available() end).

available() ->
	receive
		{request, From} ->
			From ! granted,
			gone();
		quit ->
			ok
	end.

gone() ->
	receive
		return ->
			available();
		quit ->
			ok
	end.

request(Stick) ->
	Stick ! granted,
	receive
		quit ->
			ok
	end.

return(Stick) ->
	Stick ! return.

terminate(Stick) ->
	io:format("terminate~n"),
	Stick ! quit.








