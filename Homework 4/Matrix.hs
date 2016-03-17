-- $Id: Matrix.hs,v 1.2 2013/02/26 22:35:30 leavens Exp leavens $
module Matrix (Matrix, fillWith, fromRule, numRows, numColumns, 
               at, mtranspose, mmap) where

newtype Matrix a = Mat ((Int,Int), (Int,Int) -> a)

fillWith :: (Int,Int) -> a -> (Matrix a)
fromRule :: (Int,Int) -> ((Int,Int) -> a) -> (Matrix a)
numRows :: (Matrix a) -> Int
numColumns :: (Matrix a) -> Int
at :: (Matrix a) -> (Int, Int) -> a
mtranspose :: (Matrix a) -> (Matrix a)
mmap :: (a -> b) -> (Matrix a) -> (Matrix b)

fillWith (m,n) c = Mat ((m,n), \(_,_) -> c)

fromRule (m,n) r = Mat ((m,n), r)

numRows (Mat ((m,_),_)) = m
numColumns (Mat ((_,n),_)) = n

at (Mat ((m,n),r)) (i,j) = 
    if 1 <= i && i <= m && 1 <= j && j <= n
    then r (i,j)
    else error ("indexes " ++ (show (i,j)) ++ " out of bounds")

mtranspose (Mat ((m,n),r)) = Mat ((n,m), (\(i,j) -> r (j,i)))

mmap f (Mat ((m,n),r)) = Mat ((m,n), f . r)
