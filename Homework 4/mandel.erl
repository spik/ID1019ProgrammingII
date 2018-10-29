%% @author Charlotta
%% @doc @todo Add description to mandel.


-module(mandel).

-compile(export_all).

mandelbrot(Width, Height, X, Y, K, Depth) ->
	Trans = fun(W, H) ->
					cmplx:new(X + K*(W-1), Y-K*(H-1))
			end,
	rows(Width, Height, Trans, Depth, []).

rows(Width, 0, Trans, Depth, RowList)->
	RowList;
rows(Width, Height, Trans, Depth, RowList)->
	Row = row(Width, Height, Trans, Depth, []),
	rows(Width, Height-1, Trans, Depth, [Row|RowList]).

row(0, Height, Trans, Depth, ColorList)->
	ColorList;
row(Width, Height, Trans, Depth, ColorList)->
	C = Trans(Width, Height),
	Iterations = brot:mandelbrot(C, Depth),
	Color = color:convert(Iterations, Depth),
	row(Width-1, Height, Trans, Depth, [Color|ColorList]).
	
demo() ->
	small(-2.6,1.2,1.6).
small(X,Y,X1) ->
	Width = 960,
	Height = 540,
	K = (X1 - X)/Width,
	Depth = 64,
	T0 = now(),
	Image = mandelbrot(Width, Height, X, Y, K, Depth),
	T = timer:now_diff(now(), T0),
	io:format("picture generated in ~w ms~n", [T div 1000]),
	ppm:write("small.ppm", Image).

