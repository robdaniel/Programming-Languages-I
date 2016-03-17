-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #4    --
-------------------

module MapInside where

mapInside :: (a -> b) -> [[a]] -> [[b]]
mapInside f [] = []
mapInside f [[]] = [[]]
mapInside f lls = [ map f x | x <- lls ]