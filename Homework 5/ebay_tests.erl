% $Id: ebay_tests.erl,v 1.8 2013/11/13 18:38:17 leavens Exp leavens $
-module(ebay_tests).
-import(ebay,[start/1]).
-import(testing,[eqTest/3,dotests/2]).
-export([main/0,client/3,finishAuction/1,clientStatus/1]).

main() ->
    dotests("ebay_tests $Revision: 1.8 $",tests()).

tests() ->
    tests1() ++ tests2() ++ testempty().
			  
tests1() ->
    Server = ebay:start('Florida'),
    Nelson = client(Server, 10, nelson),
    Rubio = client(Server, 8, rubio),
    Mica = client(Server, 11, mica),
    Obama = client(Server, 50, obama),
    finishAuction(Server),
    [eqTest(whoWon(Server),"==", obama),
     eqTest(clientStatus(Obama),"==",won),
     eqTest(clientStatus(Nelson),"==",lost),
     eqTest(clientStatus(Rubio),"==",lost),
     eqTest(clientStatus(Mica),"==",lost),
     eqTest(checkClosed(Server),"==",auction_is_over)].

tests2() ->
    Server = ebay:start(secret_formula),
    Agent007 = client(Server, 100, agent007),
    Agent86 = client(Server, 86, max),
    Agent99 = client(Server, 99, agent99),
    Agent992 = client(Server, 99, agent992),
    Agent100 = client(Server, 100, agent100),
    Agent1002 = client(Server, 100, agent1002),
    Agent1003 = client(Server, 100, agent1003),
    Agent1004 = client(Server, 100, agent1004),
    finishAuction(Server),
    [eqTest(checkClosed(Server),"==",auction_is_over),
     eqTest(whoWon(Server),"==",agent007),
     eqTest(clientStatus(Agent007),"==",won),
     eqTest(clientStatus(Agent86),"==",lost),
     eqTest(clientStatus(Agent99),"==",lost),
     eqTest(clientStatus(Agent992),"==",lost),
     eqTest(clientStatus(Agent100),"==",lost),
     eqTest(clientStatus(Agent1002),"==",lost),
     eqTest(clientStatus(Agent1003),"==",lost),
     eqTest(clientStatus(Agent1004),"==",lost)].

testempty() ->
    Server = ebay:start(junk),
    finishAuction(Server),
    [eqTest(checkClosed(Server),"==",auction_is_over),
     eqTest(whoWon(Server),"==",no_one)].

% Helping functions for testing below, not for you to implement.
-spec client(pid(), non_neg_integer(), atom()) -> pid().
client(Server, Amt, Info) ->
    TestPid = self(),
    CPid = spawn(fun() -> clientaction(Server, Amt, Info, TestPid) end),
    receive % Make sure it has sent its bid in before returning...
	{CPid, sent_bid} -> ok  
    end,
    CPid.
		   
-spec clientaction(pid(), non_neg_integer(), term(), pid()) -> none().
clientaction(Server, Amt, Info, TestPid) ->
    Me = self(),
    Server ! {Me, bid, Amt, Info},
    TestPid ! {Me, sent_bid},
    receive
	{you_won, _BidAmt} ->
	    clientloop(won);
	sorry -> clientloop(lost)
    after 3000 ->
	    io:format("timeout waiting for you_won or sorry message~n"),
	    exit(wrong_message)
    end.

clientloop(Status) ->
    receive
	{Pid, status} ->
	    Pid ! Status,
	    clientloop(Status)
    end.

-spec whoWon(pid()) -> term().
whoWon(Server) ->
    Server ! {self(), who_won},
    receive
	Info ->
	     Info
    end.
	
-spec clientStatus(pid()) -> won | lost.	       
clientStatus(Client) ->
    Client ! {self(), status},
    receive
	Status ->
	    Status
    end.

checkClosed(Server) ->
    Server ! {self(), bid, 6000, checkingClosed},
    receive
	Msg ->
	     Msg
    end.

-spec finishAuction(pid()) -> ok.
finishAuction(Server) ->
    Server ! {self(), finish},
    receive
	auction_closed ->
	    ok
    after 3000 ->
	    io:format("timeout waiting for auction_closed message~n"),
	    exit(wrong_message)
    end.
