import Parsers
import Prints
import Solve
import System.Environment

handleGrid :: String -> IO ()
handleGrid strGrid = do
  case parseGrid strGrid of
    Nothing -> putStrLn "Invalid input"
    Just grid -> case solve grid of
      Nothing -> putStrLn "No solution found"
      Just grid' -> putStrLn (showGrid grid')

handleInput :: [String] -> IO ()
handleInput [] = return ()
handleInput (x : xs) = do
  handleGrid x
  handleInput xs

main :: IO ()
main = do
  args <- getArgs
  fileContent <- readFile (head args)
  let testCases = lines fileContent
  handleInput testCases
