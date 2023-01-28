module Parsers (digitToInt, getNonZeroDigit, parseGrid, splitBy) where

import DataTypes (Cell (Choice, Fixed), Grid)

splitBy :: Int -> [a] -> [[a]]
splitBy _ [] = []
splitBy n xs = take n xs : splitBy n (drop n xs)

getNonZeroDigit :: Int -> Maybe Int
getNonZeroDigit n = if n > 0 && n < 10 then Just n else Nothing

digitToInt :: Char -> Int
digitToInt c = fromEnum c - fromEnum '0'

parseGrid :: String -> Maybe Grid
parseGrid s
  | length s == 81 = Just . map (map readCell) . splitBy 9 $ s
  | otherwise = Nothing
  where
    readCell c -- assumme that input is correct
      | c == '0' = Choice [1 .. 9]
      | getNonZeroDigit (digitToInt c) /= Nothing = Fixed $ digitToInt c
