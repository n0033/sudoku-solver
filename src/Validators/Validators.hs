module Validators where

import Common
import DataTypes
import Transformators

isGridFilled :: Grid -> Bool
isGridFilled grid = null [x | Choice x <- concat grid]

isRowInvalid :: [Cell] -> Bool
isRowInvalid row = hasDuplicates fixed || not (null emptyChoices)
  where
    fixed = [x | Fixed x <- row]
    emptyChoices = [x | Choice x <- row, null x]

isGridInvalid :: Grid -> Bool
isGridInvalid grid = any isRowInvalid grid || any isRowInvalid transposed || any isRowInvalid blocks
  where
    transposed = transpose grid
    blocks = blocksToRows grid
