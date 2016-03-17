%%%%%%%%%%%%%%%%%%%
%% Robert Daniel %%
%%   COP  4020   %%
%%    HW5  #6    %%
%%%%%%%%%%%%%%%%%%%

-module(ebay).
-export([start/1, loop/4]).

start(Name) -> 
	io:format("Starting auction for ~w~n", [Name]),
	spawn(?MODULE, loop, [[], 0, "", open]).

loop(BidList, Winner, Name, State) -> 
	receive
		{Pid, bid, Amt, Info} ->
			if 
				State =:= open -> 
					if 
						Amt > Winner ->
							TempBidList = [Pid|BidList],
							loop(TempBidList, Amt, Info, State);
						true ->
							TempBidList = BidList ++ [Pid],
							loop(TempBidList, Winner, Name, State)
					end;
				State =/= open ->
					Pid!auction_is_over,
					loop(BidList, Winner, Name, State)
			end;
		{Pid, finish} -> 
			Pid!auction_closed,
			if
				Winner =:= 0 ->
					loop(BidList, Winner, Name, closed);
				Winner =/= 0 ->
					hd(BidList)!{you_won, Winner},
					lists:foreach(fun(F) -> F!sorry end, tl(BidList)),
					loop(BidList, Winner, Name, closed)
			end;
		{Pid, who_won} -> 
			if
				Winner =/= 0 ->
					Pid!Name,
					loop(BidList, Winner, Name, State);
				Winner =:= 0 ->
					Pid!no_one,
					loop(BidList, Winner, Name, State)
			end
	end.