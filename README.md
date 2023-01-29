# Haskell Sudoku Solver

## Prerequisites
- ghc
- cabal

## Dependencies
There are no libraries used in this project itself except for `Prelude`.
However, the tests are using `HUnit` library.

## Running
`cabal install`  
`cabal run sudoku-solver ./test_cases`

## Running tests

Just a preview  

`cabal configure --enable-tests && cabal build` (only once)
`cabal test`

## How it works
After parsing an input, the program constructs a double-nested
list of `Fixed` or `Choice` values. `Fixed` is an `Int` represents a cell, whereas `Choice` is a list of `Int` representing a cell with multiple possible values.
Double-nested list is represented by `Grid` type.  
Then, the loaded `Grid` is cleaned up by `pruneGrid` method, removing all `Choice` values that are not possible for a cell.

The next step is choosing a pivot - assuiming that the chosen `Cell` is of `Fixed` type.  The choice may not lead to actual solution, that's why `choosePivot` method returns a pair of `Grid`.
First element of the pair is a `Grid` with the pivot chosen.
The latter is a `Grid` with the pivot removed from the `Choice` list of the chosen cell.  
When the first element of the pair does not lead to solution,
the second element is used for further processing.  

The process of choosing a pivot is repeated until the `Grid` is solved or there are no more `Choice` values left.

### Parsing input
> `src/Utils/Parsers.hs`

Expected input is a string of 81 characters, representing a sudoku grid.
`0` represents an empty cell  
`1-9` represents a cell with a number  
Parsing an input is dependant on `parseGrid`, `getNonZeroDigit`, `digitToInt` and `splitBy` functions.
The output of the `parseGrid` function is a `Grid` type, which is used for further processing

### Prunning the grid
> `src/Prune/Prune.hs`  

Prunning process done by `pruneCells` function operates on invidual rows of the `Grid`.
It collects all `Fixed` values in each row, and removes those numbers from `Choice` lists in the same row.  
Since Sudoku rules do not allow repeating numbers in a row, column or a block, the same process is applied to columns and 3x3 blocks.  
However, since the `pruneCells` method operates on rows, columns and blocks need to be transformed to invidual rows. It is realised by `transpose` and `blocksToRows` methods.
`transpose` is self-explainatory, whereas `blocksToRows` uses `splitBy 3` function to divide each row into lists of length 3. Then, in order to get a list of rows, where each row is in fact a 3x3 block, the `transpose` method is applied.
Pruning whole grid is done using `>>=` operator, so if any of the `pruneCells` calls returns `Nothing`, the whole process returns `Nothing`.

### Choosing a pivot
> `src/PivotChoice/Pivot.hs`

Pivot is chosen by looking for a cell with the least number of possible values. Then, the first value from the `Choice` list is chosen as a pivot. As said before, the pivot may not lead to a solution, that's why the `choosePivot` method returns a pair of `Grid`. If that's the case, the second element of the pair is used for further processing.

### Getting the solution
> `src/Solve/Solve.hs`

> `src/Validators/Validators.hs`

After pivot is chosen, there are certain checks performed to determine if the resulting `Grid` is valid or if it's already a solution. It is done by `isGridValid` and `isGridFilled` functions.
If the process is continued, `chooseResult` function is invoked, to choose first or second member of the pair returned by `choosePivot` method.

