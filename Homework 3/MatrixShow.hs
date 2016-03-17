module MatrixShow where
import Matrix
instance (Show a) => Show (Matrix a) where

matrixShow :: Matrix -> String

matrixShow mat = Mat ((numRows mat, numColumns mat), (\(i, j) -> (i, j)))