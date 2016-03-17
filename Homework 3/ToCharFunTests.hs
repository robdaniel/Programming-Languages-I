-- $Id: ToCharFunTests.hs,v 1.1 2013/02/11 02:51:06 leavens Exp leavens $
module ToCharFunTests where
import ToCharFun  -- your solution goes in this module
import Testing

main = dotests "ToCharFunTests $Revision: 1.1 $" tests
tests :: [TestCase Char]
tests = [eqTest (toCharFun (+3) 'a') "==" 'd'
        ,eqTest (toCharFun (+1) 'b') "==" 'c'
        ,eqTest (toCharFun (+7) 'a') "==" 'h'
        ,eqTest (toCharFun (\c -> 10*c `div` 12) 'h') "==" 'V'
        ]
