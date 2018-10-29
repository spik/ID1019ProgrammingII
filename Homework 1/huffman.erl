%% @author Charlotta
%% @doc @todo Add description to huffman.


-module(huffman).

-compile(export_all).

sample() -> "the quick brown fox jumps over the lazy dog
	this is a sample text that we will use when we build
	up a table we will only handle lower case letters and
	no punctuation symbols the frequency will of course not
	represent english but it is probably not that far off".

text() -> "this is something that we should encode".

tree(_Sample) -> na.

collectChars({Left, Right}, Bits)->
	collectChars(Left, Bits++[0]) ++ collectChars(Right, Bits++[1]);
collectChars(Char, Bits) ->
	[{Char, Bits}].
	
encode_table(_Tree) -> 
	collectChars(_Tree, []).

encode(_Text) -> 
	_Table = encode_table(huffman(freq(_Text))),
	encode(_Text, _Table, []).

encode(_, [], _) ->
	error;
encode([], _, Acc) ->
	Acc;
encode(Text, Table, Acc) ->
	[H|T] = Text,
	case lists:keyfind(H, 1, Table) of 
		{Char, Bits} ->
			encode(T, Table, Acc++Bits);
		false ->
			error
	end. 

decode_table(Text) -> 
	Table = encode_table(huffman(freq(Text))),
	Seq = encode(Text),
	decode(Seq, Table, []).

decode([], _Table, Acc) ->
	Acc;
decode(Seq, Table, Acc) ->
	{Char, Rest} = decode_char(Seq, 1, Table),
	decode(Rest, Table, Acc ++ [Char]).
decode_char(Seq, N, Table) ->
	{Code, Rest} = lists:split(N, Seq),
	case lists:keyfind(Code, 2, Table) of
		{Char, Freq} ->
			{Char, Rest};
		false ->
			decode_char(Seq, N+1, Table)
	end.

freq(Sample) -> 
	freq(Sample, []).

freq([], FreqList) ->
	FreqList;
freq([Char|Rest], FreqList) ->
	case lists:keytake(Char, 1, FreqList) of
		{value, {Char,Freq}, L} ->
			freq(Rest, [{Char, Freq+1}|L]);
		false ->
			freq(Rest, [{Char, 1}|FreqList])
	end. 

%% When all elements have been glued together we only have one element in our list. This is the tree
huffman([{Tree,Freq}]) ->
	%% Return the tree
	Tree;
huffman(FreqList) ->
	[{C1, F1}, {C2, F2}|Rest] = lists:keysort(2, FreqList),
	huffman([{{C1,C2}, F1+F2}|Rest]).









