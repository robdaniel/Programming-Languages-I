-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW2  #3    --
-------------------

module SquareEvens where

squareEvens :: [Integer] -> [Integer]
squareEvens [] = []
squareEvens (lst:lst2) = 
	if (even lst)
		then (lst * lst) : squareEvens lst2
		else (lst) : squareEvens lst2