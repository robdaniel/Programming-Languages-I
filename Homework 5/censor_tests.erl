% $Id: censor_tests.erl,v 1.1 2013/10/30 03:13:40 leavens Exp leavens $
-module(censor_tests).
-import(censor,[censor/2]).
-import(testing,[dotests/2,eqTest/3]).
-export([main/0]).
main() -> dotests("censor_tests $Revision: 1.1 $", tests()).
tests() ->
    [eqTest(censor([],[sword, fword]), "==", []),
     eqTest(censor([[], [fword], []],[sword, fword, pword]), 
	    "==", [[], [], []]),
     eqTest(censor([[fword, it]], [sword, fword]), "==", [[it]]),
     eqTest(censor([[this, is, sword, see], [fword, it]], [sword, fword]), 
	    "==", [[this, is, see], [it]]),
     eqTest(censor([[inceptis, grauibus, plerumque, et, magna, professis],
		    [purpureus, late, qui, splendeat], [unus, et, alter],
		    [adsuitur, pannus, cum, lucus, et, ara, dianae]],
		   [purpureus, et, inceptis, dianae, unus, alter]),
	    "==", [[grauibus,plerumque,magna,professis],
		   [late,qui,splendeat], [], [adsuitur,pannus,cum,lucus,ara]]),
     eqTest(censor([['@#*!+', '@#*!+', '@#*!+'], ['*^$@!', '*^$@!'],
		    [flowers, birds, trees], ['@#*!+', '*^$@!']],
		   ['@#*!+', '*^$@!']),
	    "==", [[], [], [flowers, birds, trees], []])  ].
