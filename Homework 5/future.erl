%%%%%%%%%%%%%%%%%%%
%% Robert Daniel %%
%%   COP  4020   %%
%%    HW5  #4    %%
%%%%%%%%%%%%%%%%%%%

-module(future).
-export([makeFuture/2, futureValue/1, calculate/2]).
-export_type([future/1]).
-type future(T) :: {future, pid(), T}.

makeFuture(P, ErrValue) -> 
	{future, spawn(future, calculate, [P, ErrValue]), ErrValue}.

calculate(P, ErrValue) -> 
	Ant = try P()
			catch
				throw:_ -> ErrValue;
				exit:_ -> ErrValue;
				error:_ -> ErrValue
			end,
	receive(Pid) ->
		Pid!Ant
	end.

futureValue({future, Pid, _ }) -> 
	Pid!self(),
	receive
		Response -> Response
	end.