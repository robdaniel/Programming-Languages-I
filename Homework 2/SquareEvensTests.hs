-- $Id: SquareEvensTests.hs,v 1.1 2013/08/22 19:37:47 leavens Exp leavens $
module SquareEvensTests where
import SquareEvens
import Testing
main = dotests "SquareEvensTests $Revision: 1.1 $" tests
tests :: [TestCase [Integer]]
tests = [eqTest (squareEvens []) "==" []
        ,eqTest (squareEvens [3]) "==" [3]
        ,eqTest (squareEvens [4]) "==" [16]
        ,eqTest (squareEvens [4,3]) "==" [16,3]
        ,eqTest (squareEvens [1,2,3,4,5,6]) "==" [1,4,3,16,5,36]
        ,eqTest (squareEvens [3,22,3,95,600,0,-2]) "==" [3,484,3,95,360000,0,4]
        ]
