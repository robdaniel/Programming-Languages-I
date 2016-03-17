-- $Id: Sub1ListTests.hs,v 1.1 2013/08/17 22:23:58 leavens Exp $
module Sub1ListTests where
import Testing
import Sub1List  -- you have to put your solutions in module Sub1List

version = "Sub1ListTests $Revision: 1.1 $"
recursive_tests = (tests sub1_list_rec)
comprehension_tests = (tests sub1_list_comp)

-- do main to run our tests
main :: IO()
main = do startTesting version
          errs_comp <- run_test_list 0 comprehension_tests
          total_errs <- run_test_list errs_comp recursive_tests
          doneTesting total_errs

-- do test_comprehension to test just sub1_list_comp
test_comprehension :: IO()
test_comprehension = dotests version comprehension_tests

-- do test_recursive to test just sub1_list_rec
test_recursive :: IO()
test_recursive = dotests version recursive_tests

tests :: ([Integer] -> [Integer]) -> [TestCase [Integer]]
tests f = 
    [(eqTest (f []) "==" [])
    ,(eqTest (f (1:[])) "==" (0:[]))
    ,(eqTest (f (3:1:[])) "==" (2:0:[]))
    ,(eqTest (f [1,5,7,1,7]) "==" [0,4,6,0,6])
    ,(eqTest (f [7 .. 21]) "==" [6 .. 20])
    ,(eqTest (f [8,4,-2,3,1,10000000,10])
           "==" [7,3,-3,2,0, 9999999, 9])
    ]
