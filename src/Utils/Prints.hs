module Prints where

import DataTypes (Cell (Choice, Fixed), Grid)

showGrid :: Grid -> String
showGrid = unlines . map (unwords . map showCell)
  where
    showCell (Fixed x) = show x
    showCell (Choice _) = "*"

showGridWithChoices :: Grid -> String
showGridWithChoices = unlines . map (unwords . map showCell)
  where
    showCell (Fixed x) = show x ++ "          "
    showCell (Choice xs) = (++ "}") . foldl (\acc x -> acc ++ if x `elem` xs then show x else " ") "{" $ [1 .. 9]
