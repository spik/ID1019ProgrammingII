%% @author Charlotta
%% @doc @todo Add description to env.


-module(env).

-compile(export_all).

new() ->
	[].

add(Id, Str, Env) ->
	[{Id, Str}|Env].

lookup(Id, Env) ->
	case lists:keyfind(Id, 1, Env) of
		{Id, Str} ->
			{Id, Str};
		false->
			false
	end.







