% $Id: future_tests.erl,v 1.4 2013/10/30 03:13:40 leavens Exp leavens $
-module(future_tests).
-import(future,[makeFuture/2,futureValue/1]).
-import(testing,[eqTest/3,dotests/2]).
-export([main/0]).

main() ->
    dotests("future_tests $Revision: 1.4 $", tests()).

slowfib(0) -> 0;
slowfib(1) -> 1;
slowfib(N) -> slowfib(N-1) + slowfib(N-2).

fibof30() ->
    makeFuture(fun() -> slowfib(30) end, -1).

-spec tests() -> [testing:testCase(integer())].
tests() ->
    F30 = fibof30(),
    [eqTest(futureValue(makeFuture(fun() -> 7 end,0)),"==",7),
     eqTest(futureValue(makeFuture(fun() -> slowfib(3) end,-1)),"==",2),
     eqTest(futureValue(makeFuture(fun() -> slowfib(4) end,-1)),"==",3),
     eqTest(futureValue(makeFuture(fun() -> slowfib(10) end,-1)),"==",55),
     begin
	 F2 = makeFuture(fun() -> slowfib(13) end,-1),
	 eqTest(futureValue(F2),"==",233)
     end,
     eqTest(futureValue(makeFuture(fun() -> 4000 + 20 end,0)),"==",4020),
     eqTest(futureValue(F30),"==",832040),
     % tests that use the error value (2nd argument to makeFuture):
     eqTest(futureValue(makeFuture(fun() -> throw(except) end,0)),"==",0),
     eqTest(futureValue(makeFuture(fun() -> 7/zero() end,99)),"==",99)
    ].
 
zero() -> 0.
