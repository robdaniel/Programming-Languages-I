%%%%%%%%%%%%%%%%%%%
%% Robert Daniel %%
%%   COP  4020   %%
%%    HW5  #1    %%
%%%%%%%%%%%%%%%%%%%

-module(censor).
-export([censor/2]).

-spec censor([[atom()]], [atom()]) -> [[atom()]].

censor(Document,BadWords) ->
	[ lists:flatten([ [ M ] -- BadWords || M <- N ]) || N <- Document ].