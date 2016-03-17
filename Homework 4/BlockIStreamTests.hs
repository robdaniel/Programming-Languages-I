-- $Id: BlockIStreamTests.hs,v 1.1 2013/10/09 21:12:54 leavens Exp leavens $
module BlockIStreamTests where
import BlockIStream
import RepeatingListOf -- from previous problem, used to make tests
import Testing
main :: IO()
main = dotests "BlockIStreamTests $Revision: 1.1 $" tests
tests :: [TestCase [[Char]]]
tests =
    [eqTest (take 8 (blockIStream 3 (from 'a'))) 
     "==" ["abc","def","ghi","jkl","mno","pqr","stu","vwx"]
    ,eqTest (take 13 (blockIStream 1 nowIsTheTime))
     "==" ["N","o","w"," ","i","s"," ","t","h","e"," ","t","i"]
    ,eqTest (take 13 (blockIStream 2 nowIsTheTime))
     "==" ["No","w ","is"," t","he"," t","im","e ","fo","r ","al","l ","go"]
    ,eqTest (take 10 (blockIStream 4 nowIsTheTime))
     "==" ["Now ","is t","he t","ime ","for ","all ","good"," ...","Now ","is t"]
    ,eqTest (take 6 (blockIStream 7 
                      (repeatingListOf 
                       "When in the course of human events ...")))
     "==" ["When in"," the co","urse of"," human ","events ","...When"]
    ]
-- The following are used for testing only, NOT for you to implement!
from c = c:(from (toEnum ((fromEnum c)+1)))
nowIsTheTime = (repeatingListOf "Now is the time for all good ...")

