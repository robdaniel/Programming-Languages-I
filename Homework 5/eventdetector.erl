%%%%%%%%%%%%%%%%%%%
%% Robert Daniel %%
%%   COP  4020   %%
%%    HW5  #7    %%
%%%%%%%%%%%%%%%%%%%

-module(eventdetector).
-export([start/2, loop/3]).

start(InitialState, TransitionFun) -> 
	spawn(?MODULE, loop, [[], InitialState, TransitionFun]).

loop(ObserveList, State, Fun) ->
	receive
		{Pid, add_me} ->
			Pid!{added},
			loop([Pid|ObserveList], State, Fun);
		{Pid, add_yourself_to, EDPid} ->
			EDPid!{self(), add_me},
			receive
				{added} ->
					Pid!{added},
					loop(ObserveList, State, Fun)
			end;
		{Pid, state_value} ->
			Pid!{value_is, State},
			loop(ObserveList, State, Fun);
		Atom ->
			{NewState, Event} = Fun(State, Atom),
			if
				Event =:= none ->
					loop(ObserveList, NewState, Fun);
				true ->
					lists:foreach(fun(F) -> F!Event end, ObserveList),
					loop(ObserveList, NewState, Fun)
			end
	end.