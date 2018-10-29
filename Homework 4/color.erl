%% @author Charlotta
%% @doc @todo Add description to color.


-module(color).

-compile(export_all).

convert(Depth, Max) ->
	F = Depth/Max,
	A = F*4,
	X = trunc(A),
	Y = trunc(255*(A-X)),
	case X of
		0 ->
			{Y, 0, 0};
		1 ->
			{255, Y, 0};
		2 ->
			{255-Y, 255, 0};
		3 ->
			{0, 255, Y};
		4 ->
			{0, 255-Y, 255}
	end. 
			
	














