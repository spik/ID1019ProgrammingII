%% @author Charlotta
%% @doc @todo Add description to brot.


-module(brot).

-compile(export_all).

mandelbrot(C, M) ->
	{X,Y} = C,
	Z0 = cmplx:new(X,Y),
	I = 0,
	test(I, Z0, C, M).

test(I, Z0, C, M) ->
	X = cmplx:abs(Z0),
	if 
		X >= 2 ->
			I;
		true ->
			%% Function for mandelbrot is Z0^2 + C
			brot:test(I+1, cmplx:add(cmplx:sqr(Z0), C), C, M)
	end.
		












