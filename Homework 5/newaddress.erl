%%%%%%%%%%%%%%%%%%%
%% Robert Daniel %%
%%   COP  4020   %%
%%    HW5  #2    %%
%%%%%%%%%%%%%%%%%%%

-module(newaddress).
-include("salesdata.hrl").
-export([newaddress/3]).
-import(salesdata, [store/2, group/2]).

-spec newaddress(salesdata:saledata(), string(), string()) -> salesdata:saledata().

newaddress(SD, New, Old) -> 
	if
		(is_record(SD, group)) ->
			(if 
				(SD#group.gname == Old) -> #group{gname = New, members = [ newaddress(N, New, Old) || N <- SD#group.members ]};
				true -> #group{gname = SD#group.gname, members = [ newaddress(N, New, Old) || N <- SD#group.members ]}
			end);
		(is_record(SD, store)) ->
			(if 
				(SD#store.address == Old) -> #store{address = New, amounts = SD#store.amounts};
				true -> #store{address = SD#store.address, amounts = SD#store.amounts}
			end)
	end.