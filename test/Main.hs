module Main where

import Test.Tasty
import Test.Tasty.HUnit

stub :: Bool
stub = True

tests :: TestTree
tests = testGroup "stub" 
    [
        testCase "stub should return true" $ stub @?= True
    ]

main :: IO ()
main = defaultMain tests
