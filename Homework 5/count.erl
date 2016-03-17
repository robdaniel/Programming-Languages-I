%%%%%%%%%%%%%%%%%%%
%% Robert Daniel %%
%%   COP  4020   %%
%%    HW5  #3    %%
%%%%%%%%%%%%%%%%%%%

-module(count).
-export([count/2]).

-spec count (char(), string()) -> integer().

count(What, []) ->
	0;

count(What, [S|S2]) ->
	if 
		(S == What) -> (1 + count(What, S2));
		(S /= What) -> count(What, S2)
	end.