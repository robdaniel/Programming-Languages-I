% $Id: box_tests.erl,v 1.3 2013/10/30 03:13:40 leavens Exp leavens $
-module(box_tests).
-import(box, [start/1]).
-import(testing,[eqTest/3,dotests/2]).
-export([main/0,bget/1,bset/2]).

main() ->
    dotests("box_tests $Revision: 1.3 $", tests()).

-spec tests() -> testing:testCase(integer()).
tests() ->
    B1 = box:start(1),
    B2 = box:start(2),
    [eqTest(bget(B1),"==",1),
     eqTest(bget(B2),"==",2),
     eqTest(bset(B1,99),"==",99),
     eqTest(bget(B1),"==",99),
     eqTest(bget(B2),"==",2),
     eqTest(bset(B2,3),"==",3),
     eqTest(bset(B2,5),"==",5),
     eqTest(bget(B2),"==",5),
     eqTest(bget(B1),"==",99),
     eqTest(bget(B2),"==",5)
     ].

% The following functions are used for testing purposes.
% You don't have to implement them again.
bget(Pid) ->
    Pid!{self(), get},
    receive
	{value, Value} ->
	    Value
    end.

bset(Pid, Value) ->
    Pid!{set, Value},
    Value.
