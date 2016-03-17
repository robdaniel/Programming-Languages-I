-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #6    --
-------------------

-- $Id: Matrix.hs,v 1.1 2013/09/24 14:54:21 leavens Exp leavens $
module Matrix (Matrix, fillWith, fromRule, numRows, numColumns, 
               at, mtranspose, mmap) where

newtype Matrix a = Mat ((Int,Int),(Int,Int) -> a)

fillWith :: (Int,Int) -> a -> (Matrix a)
fromRule :: (Int,Int) -> ((Int,Int) -> a) -> (Matrix a)
numRows :: (Matrix a) -> Int
numColumns :: (Matrix a) -> Int
at :: (Matrix a) -> (Int, Int) -> a
mtranspose :: (Matrix a) -> (Matrix a)
mmap :: (a -> b) -> (Matrix a) -> (Matrix b)

-- Without changing what is above, implement the above functions.

fillWith (m, n) e = Mat ((m, n), (\(i, j) -> e))

fromRule (m, n) g = Mat ((m, n), (\(i, j) -> g(i, j)))

numRows (Mat ((m, n), f)) = m

numColumns (Mat ((m, n), f)) = n

at (Mat ((m, n), f)) (i, j) = if ((i <= m) && (i >= 1) && (j <= n) && (j >= 1))
								then f(i, j)
								else error "One index is out of range"

mtranspose (Mat ((m, n), f)) = (Mat ((n, m), (\(i, j) -> f(j, i))))

mmap f (Mat ((m, n), g)) = (Mat ((m, n), (\(i, j) -> f(g(i, j)))))
