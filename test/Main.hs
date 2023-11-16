module Main where

import Test.Tasty
import Test.Tasty.HUnit

import Helpers

data TestFile = TestFile { filePath :: String, timeStamp :: Int } deriving (Show, Eq)

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
                f1 = TestFile "a" 123
                f2 = TestFile "a" 123
            in
                testCase "testing TestFile" $ f1 @?= f2
        ]
    ]

main :: IO ()
main = defaultMain unitTests
