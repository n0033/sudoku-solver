module Common where

hasDuplicates :: Eq a => [a] -> Bool
hasDuplicates list = hasDuplicates' list []

hasDuplicates' :: Eq a => [a] -> [a] -> Bool
hasDuplicates' [] _ = False
hasDuplicates' (y : ys) xs
  | y `elem` xs = True
  | otherwise = hasDuplicates' ys (y : xs)

-- similar to standard `until` function
-- repeats function on an argument until the result
-- is not the same as before
-- support monads
untilEqual :: (Monad m, Eq a) => (a -> m a) -> a -> m a
untilEqual f x = f x >>= \result -> if result == x then return x else untilEqual f result

-- removes every occurence of given element from list
removeFromList :: Eq a => [a] -> a -> [a]
removeFromList xs element = [x | x <- xs, x /= element]

listsDiff :: Eq a => [a] -> [a] -> [a]
listsDiff minuend subtrahend = filter (`notElem` subtrahend) minuend

mapOnce :: (a -> Maybe a) -> [a] -> [a]
mapOnce _ [] = []
mapOnce f (x : xs) = case f x of
  Nothing -> x : mapOnce f xs
  Just y -> y : xs

replaceFirst :: Eq a => [a] -> a -> a -> [a]
replaceFirst items old new = mapOnce check items
  where
    check item
      | item == old = Just new
      | otherwise = Nothing

splitBy :: Int -> [a] -> [[a]]
splitBy _ [] = []
splitBy n xs = take n xs : splitBy n (drop n xs)
