-- $Id: MatrixAddTests.hs,v 1.1 2013/02/11 14:53:44 leavens Exp leavens $
module MatrixAddTests where
import Matrix
import MatrixInstances
import MatrixAdd
import Testing

main = dotests "MatrixAddTests $Revision: 1.1 $" tests

-- helpers for testing below, NOT something you have to implement
allIndexes :: (Int,Int) -> [(Int,Int)]
allIndexes (m,n) = [(i,j) | i <- [1..m], j <- [1..n]]
zeros = fillWith (4,3) 0
id4x3 = fromRule (4,3) (\(i,j) -> if i == j then 1 else 0)
m4x3 = fromRule (4,3) (\(i,j) -> 10*i+j)
m9 = fillWith (4,3) 9

tests :: [TestCase (Matrix Int)]
tests =
    [eqTest (zeros `add` id4x3) "==" id4x3
    ,eqTest (m9 `sub` zeros) "==" m9
    ,eqTest (m9 `sub` id4x3) 
     "==" (fromRule (4,3) (\(i,j) -> if i == j then 8 else 9))
    ,eqTest (m9 `sub` m4x3) 
     "==" (fromRule (4,3) (\(i,j) -> 9 - (10*i+j)))
    ,eqTest (m9 `add` m4x3) 
     "==" (fromRule (4,3) (\(i,j) -> 9 + (10*i+j)))
    ,eqTest (m9 `add` m4x3) 
     "==" (fromRule (4,3) (\(i,j) -> 9 + (10*i+j)))
    ]
