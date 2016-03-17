-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW4  #9    --
-------------------

module EncryptIStream where
import IStream
import Data.List

encryptIStream :: Int -> ([Char] -> [Char]) -> (IStream Char) -> (IStream Char)
encryptIStream blockSize encrypt istrm = join "" (encrypt(x) : [(encryptIStream blockSize encrypt xs)])
	where
		(x,xs) = splitAt blockSize istrm

join :: [a] -> [[a]] -> [a]
join a b = concat (intersperse a b)