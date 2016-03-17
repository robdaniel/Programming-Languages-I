% $Id: salesdata.erl,v 1.3 2013/10/30 03:13:40 leavens Exp leavens $
-module(salesdata).
-include("salesdata.hrl").
-export_type([salesdata/0]).

-type salesdata() :: #store{} | #group{}.
