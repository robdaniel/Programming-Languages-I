-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #8    --
-------------------

-- $Id: InfBag.hs,v 1.1 2013/09/24 14:34:31 leavens Exp leavens $
module InfBag where
import qualified Data.Map as Map
import Data.Map (Map)

fromFunc :: (a -> Integer) -> (Bag a)
minusBag :: Bag a -> Bag a -> Bag a
unionBag :: Bag a -> Bag a -> Bag a
intersectBag :: Bag a -> Bag a -> Bag a
number :: a -> Bag a -> Integer

-- define the type (Bag a) as one of the following and then...

data Bag a = Bag2 (a -> Integer)

-- Write your code below for the opertions declared above...

fromFunc f = Bag2 f

minusBag (Bag2 f) (Bag2 g) = Bag2 (\x -> max 0 ((f x) - (g x)))

unionBag (Bag2 f) (Bag2 g) = Bag2 (\x -> (f x) + (g x))

intersectBag (Bag2 f) (Bag2 g) = Bag2 (\x -> min (f x) (g x))

number n (Bag2 f) = f n
