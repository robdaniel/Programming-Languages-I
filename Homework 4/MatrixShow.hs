-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW4  #3    --
-------------------

module MatrixShow where
import Matrix
import Data.List (intersperse)

instance (Show a) => Show (Matrix a) where
	show mat = (concat (intersperse (" \n") [matrixShowRows x | x <- [1..(numRows mat)] ])) ++ " \n"
		where
			matrixShowRows x = concat (intersperse (" ") [ show (mat `at` (x, y)) | y <- [1..(numColumns mat)] ])
