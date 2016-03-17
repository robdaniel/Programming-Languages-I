-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #1    --
-------------------

module Rank where
import qualified Data.List as List

rank :: (Ord a) => [a] -> [(Int, a)]
rank [] = []
rank things = rank' 1 2 (List.sort things)

rank' :: (Ord a) => Int -> Int -> [a] -> [(Int, a)]
rank' a b (lst:[]) = (a, lst) : []
rank' a b (lst:peak @ (lst2:_)) 
	| (compare lst lst2) == EQ		= (a, lst) : rank' (a) (b+1) peak
	| otherwise						= (a, lst) : rank' (b) (b+1) peak