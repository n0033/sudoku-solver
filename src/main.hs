import Parsers
import Prints
import Prune
import Transformators
import Prelude

main :: IO ()
main = do
  putStrLn (showGridWithChoices grid)
  putStrLn (showGridWithChoices pruned)
  where
    Just grid = parseGrid "600000010400000000020000000000050407008000300001090000300400200050100000000806000"
    Just pruned = pruneGrid grid
