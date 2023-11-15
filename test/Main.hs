module Main where

import Test.Tasty
import Test.Tasty.HUnit

import Helpers

tests :: TestTree
tests = 
    testGroup "Unit Tests"
    [ 
        testGroup "endsWith" 
        [
            testCase "does not end with" $ endsWith ".hs" "file.js" @?= False,
            testCase "does end with" $ endsWith ".hs" "file.hs" @?= True
        ],
        testGroup "removeSuffix" 
        [
            testCase "suffix does not exist" $ removeSuffix "/" "a/b/c" @?= "a/b/c",
            testCase "suffix does not exist" $ removeSuffix "/" "a/b/c/" @?= "a/b/c"
        ]
    ]

main :: IO ()
main = defaultMain tests
