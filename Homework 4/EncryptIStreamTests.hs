-- $Id: EncryptIStreamTests.hs,v 1.1 2013/10/09 21:12:54 leavens Exp leavens $
module EncryptIStreamTests where
import IStream
import EncryptIStream
import RepeatingListOf -- from previous problem, used to make tests
import Testing
main :: IO()
main = dotests "EncryptIStreamTests $Revision: 1.1 $" tests
tests :: [TestCase [Char]]
tests =
    [eqTest (take 24 (runTest 3 noEncryption (from 'a')))
     "==" "abcdefghijklmnopqrstuvwx"
    ,eqTest (take 26 (runTest 2 reverseNoEncryption nowIsTheTime))
     "==" "oN wsit eht mi eof rla log"
    ,eqTest (take 40 (runTest 4 (ceaserCypher 1) nowIsTheTime))
     "==" "Opx!jt!uif!ujnf!gps!bmm!hppe!///Opx!jt!u"
    ,eqTest (take 48 (runTest 8 (reverseCeaserCypher 3)
                      (repeatingListOf 
                       "When in the course of human events ...")))
     "==" "#ql#qhkZuxrf#hkwxk#ir#hvqhyh#qdpkZ111#vwkw#ql#qh"
    ]
-- The following are used for testing only, NOT for you to implement!
runTest :: Int -> ([Char] -> [Char]) -> (IStream Char) -> (IStream Char)
runTest n encrypt istrm = encryptIStream n (wrap encrypt) istrm
    where wrap f str = if length str == n 
                       then f str 
                       else error "wrong block size passed to encryption function!"
noEncryption = id
reverseNoEncryption = reverse
charSize = (fromEnum (maxBound :: Char))+1
ceaserCypher :: Int -> String -> String
ceaserCypher n str = 
    map (\c -> toEnum (((fromEnum c)+n) `mod` charSize)) str
reverseCeaserCypher n str = reverse (ceaserCypher n str)
from c = c:(from (toEnum (((fromEnum c)+1) `mod` charSize)))
nowIsTheTime = (repeatingListOf "Now is the time for all good ...")
