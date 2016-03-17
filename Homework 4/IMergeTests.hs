-- $Id: IMergeTests.hs,v 1.2 2013/10/21 18:13:15 leavens Exp leavens $
module IMergeTests where
import IMerge
import Testing
main :: IO()
main = dotests "IMergeTests $Revision: 1.2 $" tests
tests :: [TestCase [Integer]]
tests = 
    [eqTest (take 10 (imerge [0,2 ..] [1,3 ..])) "==" [0,1,2,3,4,5,6,7,8,9]
    ,eqTest (take 12 (imerge [1 ..] [1 ..])) "==" [1,1,2,2,3,3,4,4,5,5,6,6]
    ,eqTest (take 15 (imerge [-1,1 ..] [4,8 ..]))
     "==" [-1,1,3,4,5,7,8,9,11,12,13,15,16,17,19]
    ,eqTest (take 16 (imerge (map (\x -> x*x) [0,2 ..]) 
                             (map (\x -> x^3) [-3,-1 ..])))
     "==" [-27,-1,0,1,4,16,27,36,64,100,125,144,196,256,324,343]
    ,eqTest (take 17 (imerge [1,1 ..] [3,3 ..]))
     "==" [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
    ,eqTest (take 17 (imerge [4,4 ..] ([2,2,2]++[3,3 ..])))
     "==" [2,2,2,3,3,3,3,3,3,3,3,3,3,3,3,3,3]
    ]
