module Types where

data Cell = Fixed Int | Possible [Int] deriving (Eq, Show)

type Row = [Cell]

type Grid = [Row]
