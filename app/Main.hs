module Main where

import System.Environment
import System.Directory

main :: IO ()
main = do 
    args <- getArgs
    putStrLn "Hello, Haskell!"
    print (head args)
    path <- (makeAbsolute ".")
    putStrLn path
