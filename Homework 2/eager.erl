%% @author Charlotta
%% @doc @todo Add description to eager.


-module(eager).

-compile(export_all).

eval_expr({atm, Id}, _) ->
	{ok, Id};

eval_expr({var, Id}, Env) ->
	case env:lookup(Id, Env) of
		false ->
			error;
		{Id, Str} ->
			{ok, Str}
	end;

eval_expr({cons, Exp1, Exp2}, Env) ->
	case eval_expr(Exp1, Env) of
		error ->
			error;
		{ok, Str} ->
			case eval_expr(Exp2, Env) of
				error ->
					error;
				{ok, Str2} ->
					{ok, {Str,Str2}}
			end
	end.

eval_match(ignore, _, Env) ->
	{ok, Env};

eval_match({atm, Id}, Id, Env) ->
	{ok, Env};

eval_match({var, Id}, Str, Env) ->
	case env:lookup(Id, Env) of
		false ->
			{ok, env:add(Id, Str, Env)};
		{Id, Str} ->
			{ok, Env};
		{Id, _} ->
			fail
	end;

eval_match({cons, Ptr1, Ptr2}, {A,B}, Env) ->
	case eval_match(Ptr1, A, Env) of
		fail ->
			fail;
		{ok, NewEnv} ->
			eval_match(Ptr2, B, NewEnv)
	end;

eval_match(_, _, _) ->
	fail.

eval_seq([Exp], Env) ->
	eval_expr(Exp, Env);

eval_seq([{match, Ptr, Exp}|Seq], Env) ->
	case eval_expr(Exp, Env) of
		error ->
			env:add(Exp, Ptr, Env);
	{ok, Str} ->
		case eval_match(Ptr, Str, Env) of
			fail ->
				error;
			{ok, ExtendedEnv} ->
				eval_seq(Seq, ExtendedEnv)
		end
	end.

eval(Seq)->
	%% We create a new environment to use in our sequence code. 
	eval_seq(Seq, env:new()).












