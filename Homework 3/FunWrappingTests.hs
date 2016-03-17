-- $Id: FunWrappingTests.hs,v 1.2 2013/09/24 18:55:42 leavens Exp leavens $
module FunWrappingTests where
import Prelude hiding (catch)
import FunWrapping
import Testing
import Control.Exception (try,catch)

main = dotests "FunWrappingTests $Revision: 1.2 $" tests

tests :: [TestCase Integer]
tests =
    [eqTest (pre (>0) (+10) 5) "==" 15
    ,eqTest (pre (<0) abs (negate 3)) "==" 3
    ,eqTest (post (\x y -> x < y) (+2) 3) "==" 5
    ,eqTest (post (\x y -> x == y) id 4) "==" 4
    ,eqTest (inv (== 3) id 3) "==" 3
    ,eqTest (inv (>6) (+7) 7) "==" 14
    ]
