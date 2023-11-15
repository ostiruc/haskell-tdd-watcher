module Main where

import Test.Tasty
import Test.Tasty.HUnit

import Helpers

tests :: TestTree
tests = 
    testGroup "endsWith" 
    [
        testCase "does not end with" $ endsWith ".hs" "file.js" @?= False,
        testCase "does end with" $ endsWith ".hs" "file.hs" @?= True
    ]

main :: IO ()
main = defaultMain tests
