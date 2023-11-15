module Main where

import Test.Tasty
import Test.Tasty.HUnit
import Helpers

tests :: TestTree
tests = 
    testGroup "endsWith" 
    [
        testCase "stub" $ endsWith "foo" "bar" @?= False
    ]

main :: IO ()
main = defaultMain tests
