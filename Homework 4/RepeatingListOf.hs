-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW4  #7    --
-------------------

module RepeatingListOf where
import IStream

repeatingListOf :: [t] -> (IStream t)
repeatingListOf a = a' where a' = a ++ a'