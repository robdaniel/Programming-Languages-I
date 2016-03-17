-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #3    --
-------------------

module ToCharFun where

toCharFun :: (Int -> Int) -> (Char -> Char)
toCharFun f1 f2 = toEnum (f1 (fromEnum f2))