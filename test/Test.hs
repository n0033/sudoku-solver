import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit
import TestCommon

tests =
  hUnitTestToTests $
    TestList
      [ TestLabel
          "testHasDuplicatesOneDuplicate"
          testHasDuplicatesOneDuplicate,
        TestLabel
          "testHasDuplicateManyDuplicates"
          testHasDuplicatesManyDuplicates,
        TestLabel
          "testHasDuplicatesNoDuplicates"
          testHasDuplicatesNoDuplicates
      ]

main :: IO ()
main = defaultMain tests
