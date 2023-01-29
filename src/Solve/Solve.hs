module Solve where

import DataTypes
import Pivot
import Prune
import Validators

chooseResult :: Maybe Grid -> Maybe Grid -> Maybe Grid
chooseResult (Just first) _ = Just first
chooseResult Nothing (Just second) = Just second
chooseResult _ _ = Nothing

solve :: Grid -> Maybe Grid
solve grid = pruneGrid grid >>= solve'
  where
    solve' g
      | isGridInvalid g = Nothing
      | isGridFilled g = Just g
      | otherwise =
        let (firstGrid, secondGrid) = choosePivot g
         in chooseResult (solve firstGrid) (solve secondGrid)
