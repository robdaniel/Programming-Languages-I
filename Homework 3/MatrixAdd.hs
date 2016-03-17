-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #7    --
-------------------

-- $Id: MatrixAdd.hs,v 1.1 2013/09/24 14:54:21 leavens Exp leavens $
module MatrixAdd where
import Matrix
import MatrixInstances

sameShape :: (Matrix a) -> (Matrix a) -> Bool
pointwiseApply :: (a -> a -> b) -> (Matrix a) -> (Matrix a) -> (Matrix b)
add :: (Num a) => (Matrix a) -> (Matrix a) -> (Matrix a)
sub :: (Num a) => (Matrix a) -> (Matrix a) -> (Matrix a)

-- without changing the above, implement the declared functions.

sameShape m1 m2
	| (((numRows m1) == (numRows m2)) && ((numColumns m1) == (numColumns m2)))	= True
	| otherwise																	= False

pointwiseApply op m1 m2 
	| (sameShape m1 m2 == True) 	= fromRule ((numRows m1), (numColumns m1)) (\(i, j) -> ((m1 `at` (i,j)) `op` (m2 `at` (i,j))))
	| otherwise																	= error "Two matrices do not have the same shape"

add m1 m2 = pointwiseApply (+) m1 m2

sub m1 m2 = pointwiseApply (-) m1 m2
