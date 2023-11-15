module Main where

import Test.Tasty
import Test.Tasty.HUnit

endsWith :: String -> String -> Bool
endsWith _ _ = False

tests :: TestTree
tests = 
    testGroup "endsWith" 
    [
        testCase "stub" $ endsWith "foo" "bar" @?= False
    ]

main :: IO ()
main = defaultMain tests
