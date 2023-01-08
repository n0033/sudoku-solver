module Utils where

getNonZeroDigit :: Int -> Maybe Int
getNonZeroDigit n = if n > 0 && n < 10 then Just n else Nothing

chunksOf :: Int -> [a] -> [[a]]
chunksOf _ [] = []
chunksOf n xs = take n xs : chunksOf n (drop n xs)

digitToInt :: Char -> Int
digitToInt c = fromEnum c - fromEnum '0'
