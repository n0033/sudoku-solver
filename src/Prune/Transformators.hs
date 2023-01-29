module Transformators where

import Common (splitBy)

transpose :: [[a]] -> [[a]]
transpose [] = []
transpose ([] : xss) = transpose xss
transpose ((x : xs) : xss) = (x : fmap head xss) : transpose (xs : fmap tail xss)

blocksToRows :: [[a]] -> [[a]]
blocksToRows grid = splitBy 9 . concatMap concat . concatMap transpose $ splitted
  where
    splitted = splitBy 3 (map (splitBy 3) grid)
