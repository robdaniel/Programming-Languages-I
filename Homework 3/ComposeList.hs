-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #5    --
-------------------

module ComposeList where

composeList :: [(a -> a)] -> (a -> a)
composeList fs v = (foldl (.) id fs) $ v