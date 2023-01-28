module DataTypes where

data Cell = Fixed Int | Choice [Int] deriving (Eq, Show)

type Row = [Cell]

type Grid = [Row]
