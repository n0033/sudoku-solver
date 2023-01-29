module Pivot where

import Common (removeFromList, replaceFirst, splitBy)
import DataTypes (Cell (Choice, Fixed), Grid)

getCellChoiceCount :: Cell -> Int
getCellChoiceCount (Fixed _) = 1
getCellChoiceCount (Choice cell) = length cell

getGridChoiceCount :: [[Cell]] -> [[Int]]
getGridChoiceCount = result
  where
    result = map (map getCellChoiceCount)

-- finds minimum value, higher than 1
getMinimumChoiceCount :: [Int] -> Int
getMinimumChoiceCount = foldr min 9 . filter (1 <)

-- (Choices length, Cell)
getPivot :: Grid -> Cell
getPivot grid = pivot
  where
    pivot = Choice . head . filter (\x -> length x == choiceCount) $ choiceCells
    choiceCells = [x | Choice x <- concat grid]
    choiceCount = getMinimumChoiceCount . concat . getGridChoiceCount $ grid

-- removes choosen pivot from `Cells` with `Choice`
choosePivotInCell :: Cell -> Cell -> Cell
choosePivotInCell (Fixed replaceable) _ = Fixed replaceable
choosePivotInCell (Choice replaceable) (Fixed replacement) = if not (any (replacement /=) replaceable) then Choice replaceable else Fixed replacement
choosePivotInCell (Choice replaceable) (Choice _) = Choice replaceable

-- finds a pivot by finding a `Cell` with lowest amount of `Choices`
-- Returns pair `Grids`:
-- 1) where Cell from which pivot is chosen is marked as `Fixed <pivot>`
-- 2) Cell from which pivot is chosen has all the `Choices` but the pivot
-- the latter is used when first `Grid` does not lead to solution
choosePivot :: Grid -> (Grid, Grid)
choosePivot grid = (first, second)
  where
    first = splitBy 9 firstReplacedGrid
    second = splitBy 9 secondReplacedGrid
    firstReplacedGrid = replaceFirst concatGrid (Choice pivot) (Fixed (head pivot))
    secondReplacedGrid = replaceFirst concatGrid (Choice pivot) (Choice (removeFromList pivot (head pivot)))
    Choice pivot = getPivot grid
    concatGrid = concat grid
