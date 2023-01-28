module Prune where

import DataTypes (Cell (Choice, Fixed), Grid)
import Transformators (blocksToRows, transpose)
import Until (untilEqual)

getFixedElements :: [Cell] -> [Int]
getFixedElements cells = [x | Fixed x <- cells]

-- removes every occurence of given element from list
removeFromList :: Eq a => [a] -> a -> [a]
removeFromList xs element = [x | x <- xs, x /= element]

listsDiff :: Eq a => [a] -> [a] -> [a]
listsDiff minuend subtrahend = filter (`notElem` subtrahend) minuend

pruneCell :: Cell -> [Int] -> Maybe Cell
pruneCell (Fixed cell) _ = Just (Fixed cell)
pruneCell (Choice cell) fixedElems = case listsDiff cell fixedElems of
  [] -> Nothing
  [y] -> Just (Fixed y)
  ys -> Just (Choice ys)

-- Removes elements from `Cells` of `Choice` type passed in the argument.
-- The elements for removal are `Cells` of `Fixed` type.
-- Can be used to remove redundant `choices` for any cell list,
-- which can be a logical row, column or a 3x3 block (in list representation).
-- The result is `Nothing` when there is a cell with no possible choices left.
pruneCells :: [Cell] -> Maybe [Cell]
pruneCells cells = traverse (`pruneCell` fixed) cells
  where
    fixed = getFixedElements cells

-- Prunes `Choices` from `Cells`
-- which are present in `Fixed` elements
-- collected from each row, column or block
singleGridPrune :: Grid -> Maybe Grid
singleGridPrune grid =
  traverse pruneCells grid
    >>= fmap transpose . traverse pruneCells . transpose
    >>= fmap blocksToRows . traverse pruneCells . blocksToRows

pruneGrid :: Grid -> Maybe Grid
pruneGrid = untilEqual singleGridPrune
