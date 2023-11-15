module Main where

import Test.Tasty
import Test.Tasty.HUnit

import Helpers

unitTests :: TestTree
unitTests = 
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
        ],
        testGroup "scratch"
        [
            let 
                dirContents = [".", "..", "a"]
                fold = foldr (\x acc -> filter (/= x) acc) dirContents [".", ".."]
            in
                testCase "testing foldr" $ fold @?= ["a"]
        ]
    ]

main :: IO ()
main = defaultMain unitTests
