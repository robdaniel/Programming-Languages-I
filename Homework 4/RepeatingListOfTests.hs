-- $Id: RepeatingListOfTests.hs,v 1.1 2013/10/09 21:12:54 leavens Exp leavens $
module RepeatingListOfTests where
import RepeatingListOf
import Testing
main :: IO()
main = dotests "RepeatingListOfTests $Revision: 1.1 $" tests
tests :: [TestCase [Integer]]
tests = 
    [eqTest (take 10 (repeatingListOf [1])) "==" [1,1,1,1,1,1,1,1,1,1]
    ,eqTest (take 10 (drop 5000 (repeatingListOf [7]))) 
     "==" [7,7,7,7,7,7,7,7,7,7]
    ,eqTest (take 11 (drop 50000 (repeatingListOf [2,3,4,5,6]))) 
     "==" [2,3,4,5,6,2,3,4,5,6,2]
    ,eqTest (take 13 (repeatingListOf [9,22,-1,3,7]))
     "==" [9,22,-1,3,7,9,22,-1,3,7,9,22,-1]
    ,eqTest (take 17 (repeatingListOf [4,0,2,0,5,0,2,1]))
     "==" [4,0,2,0,5,0,2,1,4,0,2,0,5,0,2,1,4]
    ]
