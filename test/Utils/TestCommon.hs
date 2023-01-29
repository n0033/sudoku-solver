module TestCommon where

import Common
import Test.Framework
import Test.Framework.Providers.HUnit
import Test.HUnit

testHasDuplicatesOneDuplicate = TestCase (assertEqual "hasDuplicates [1, 2, 3, 4, 2" True (hasDuplicates [1, 2, 3, 4, 2]))

testHasDuplicatesManyDuplicates = TestCase (assertEqual "hasDuplicates [1, 2, 2, 4, 2]" True (hasDuplicates [1, 2, 2, 4, 2]))

testHasDuplicatesNoDuplicates = TestCase (assertEqual "hasDuplicates [1, 2, 3, 4, 5]" False (hasDuplicates [1, 2, 3, 4, 5]))
