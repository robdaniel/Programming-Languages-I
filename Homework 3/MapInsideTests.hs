-- $Id: MapInsideTests.hs,v 1.2 2013/09/24 18:55:42 leavens Exp leavens $
module MapInsideTests where
import Testing
import ToCharFun -- used for testing
import MapInside  -- you have to put your solutions in module MapInside

version = "MapInsideTests $Revision: 1.2 $"

-- do main to run our tests
main :: IO()
main = do startTesting version
          errs_ints <- run_test_list 0 int_tests
          total_errs <- run_test_list errs_ints string_tests
          doneTesting total_errs

int_tests :: [TestCase [[Int]]]
int_tests =
    [eqTest (mapInside (+1) []) "==" []
    ,eqTest (mapInside (+1) [[]]) "==" [[]]
    ,eqTest (mapInside (*2) [[3,4,5],[4,0,2,0],[],[8,7,6]])
      "==" [[6,8,10],[8,0,4,0],[],[16,14,12]]
    ,eqTest (mapInside (*2) [[1 .. 10], [2,4 .. 20], [7]]) 
      "==" [[2,4 .. 20], [4,8 .. 40], [14]]
    ,eqTest (mapInside (3*) [[0 .. 10], [0,2 .. 10], [7]]) 
      "==" [[0,3 .. 30], [0,6 .. 30], [21]]
    ,eqTest (mapInside (\n -> 3*n + 1) [[0,7,17,27], [94,5]])
      "==" [[1,22,52,82],[283,16]]
    ]

string_tests :: [TestCase [[Char]]]
string_tests = 
    [eqTest (mapInside (toCharFun (+1)) ["A string", "is a list!"])
             "==" ["B!tusjoh","jt!b!mjtu\""]
    ,eqTest (mapInside (toCharFun (\x -> x-7)) ["UCF","CS","is","great"])
             "==" ["N<?","<L","bl","`k^Zm"]
    ,eqTest (mapInside (toCharFun (+7)) ["N<?","<L","bl","`k^Zm"])
             "==" ["UCF","CS","is","great"]
     ]
