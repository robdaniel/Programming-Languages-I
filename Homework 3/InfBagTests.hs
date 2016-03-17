-- $Id: InfBagTests.hs,v 1.1 2013/09/24 14:34:31 leavens Exp leavens $
module InfBagTests where
import InfBag
import Testing
main :: IO ()
main = dotests "InfBagTests $Revision: 1.1 $" tests
tests :: [TestCase Integer]
tests =
    [(eqTest (number "coke" coke6) "==" 6)
    ,(eqTest (number "pepsi" coke6) "==" 0)
    ,(eqTest (number "pepsi" pepsi12) "==" 12)
    ,(eqTest (number 'e' eBag) "==" 999573)
    ,(eqTest (number 'a' eBag) "==" 0)
    ,(eqTest (number 'a' letterBag) "==" 99)
    ,(eqTest (number 10 squareBag) "==" 100)
    ,(eqTest (number (-5) squareBag) "==" 25)
    ,(eqTest (number 9999999 squareBag) "==" (9999999^2))
    ,(eqTest (number 100000000 np1Bag) "==" 100000001)
    ,(eqTest (number "coke" (pepsi12 `minusBag` coke6)) "==" 0)
    ,(eqTest (number "pepsi" (pepsi12 `minusBag` coke6)) "==" 12)
    ,(eqTest (number "pepsi" (pepsi12 `minusBag` (simpleBag "pepsi" 3))) "==" 9)
    ,(eqTest (number "pepsi" (pepsi12 `minusBag` pepsi12)) "==" 0)
    ,(eqTest (number "pepsi" (pepsi12 `unionBag` coke6)) "==" 12)
    ,(eqTest (number "pepsi" (pepsi12 `unionBag` pepsi12)) "==" 24)
    ,(eqTest (number "coke" (pepsi12 `unionBag` coke6)) "==" 6)
    ,(eqTest (number "coke" (coke6 `unionBag` coke6)) "==" 12)
    ,(eqTest (number "sprite" (pepsi12 `unionBag` coke6)) "==" 0)
    ,(eqTest (number "sprite" (pepsi12 `unionBag` coke6)) "==" 0)
    ,(eqTest (number 'e' (eBag `unionBag` letterBag)) "==" (999573 + 4020))
    ,(eqTest (number "pepsi" (pepsi12 `intersectBag` coke6)) "==" 0)
    ,(eqTest (number "coke" (pepsi12 `intersectBag` coke6)) "==" 0)
    ,(eqTest (number "sprite" (pepsi12 `intersectBag` coke6)) "==" 0)
    ,(eqTest (number "pepsi" (pepsi12 `intersectBag` pepsi12)) "==" 12)
    ,(eqTest (number 'e' (eBag `intersectBag` letterBag)) "==" 4020)
    ]
  where simpleBag what num = fromFunc (\x -> if x == what then num else 0)
        coke6 = simpleBag "coke" 6
        pepsi12 = simpleBag "pepsi" 12
        eBag = simpleBag 'e' 999573
        letterBag = fromFunc (\c -> if c == 'e' then 4020 else if c == 'a' then 99 else 0)
        squareBag = fromFunc (\i -> i*i)
        np1Bag = fromFunc (\n -> n+1)
