% $Id: count_tests.erl,v 1.1 2013/10/30 03:13:40 leavens Exp leavens $
-module(count_tests).
-import(count,[count/2]).
-import(testing,[dotests/2,eqTest/3]).
-export([main/0]).
main() -> dotests("count_tests $Revision: 1.1 $", tests()).
tests() ->
    [eqTest(count($c,[]), "==", 0),
     eqTest(count($i, [$M,$i,$s,$s,$i,$s,$s,$i,$p,$p,$i]), "==", 4),
     eqTest(count($p, "Mississippi"), "==", 2),
     eqTest(count($p, "principles of programming parallel programs"), "==", 5),
     eqTest(count($., ".........................."), "==", 26)
    ].
