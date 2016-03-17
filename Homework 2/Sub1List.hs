-------------------
-- Robert Daniel --
--   COP  4020   --
--    HW2  #2    --
-------------------

module Sub1List where

sub1_list_comp :: [Integer] -> [Integer]
sub1_list_comp lst1 = [x-1 | x <- lst1]

sub1_list_rec :: [Integer] -> [Integer]
sub1_list_rec [] = []
sub1_list_rec (list2:list3) = (list2 - 1) : sub1_list_rec list3