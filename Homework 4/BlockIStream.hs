-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW4  #8    --
-------------------

module BlockIStream where
import IStream

blockIStream :: Int -> (IStream Char) -> (IStream [Char])
blockIStream blockSize istrm = x : (blockIStream blockSize xs)
	where
		(x,xs) = splitAt blockSize istrm