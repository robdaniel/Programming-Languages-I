%%%%%%%%%%%%%%%%%%%
%% Robert Daniel %%
%%   COP  4020   %%
%%    HW5  #5    %%
%%%%%%%%%%%%%%%%%%%

-module(box).
-export([start/1, loop/1]).

start(Value1) -> 
	spawn(box, loop, [Value1]).

loop(Value2) ->
	receive
		{Pid, get} ->
			Pid!{value, Value2};
		{set, NewVal} -> 
			loop(NewVal);
		Value2 ->
			Value2
	end,
	loop(Value2).