-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW4  #6    --
-------------------

module IMerge where
import IStream

imerge :: (Ord t) => (IStream t) -> (IStream t) -> (IStream t)
imerge (a:as) (b:bs)
	| (a <= b)	= a : imerge as (b:bs)
	| (a > b)	= b : imerge (a:as) bs