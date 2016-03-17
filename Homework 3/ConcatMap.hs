-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW3  #9    --
-------------------

module ConcatMap where
import Prelude hiding (concatMap)

concatMap :: (a -> [b]) -> [a] -> [b]
concatMap f ls = foldr ((++) . f) [] ls