module Until where

-- similar to standard `until` function
-- repeats function on an argument until the result
-- is not the same as before
-- support monads
untilEqual :: (Monad m, Eq a) => (a -> m a) -> a -> m a
untilEqual f x = f x >>= \result -> if result == x then return x else untilEqual f result
