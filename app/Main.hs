module Main where

import System.Environment
import System.Directory

resolvePathToWatch = do
    args <- getArgs
    path <- (makeAbsolute (head args))
    return path

main :: IO ()
main = do 
    pathToWatch <- resolvePathToWatch
    putStrLn ("Watching: " ++ pathToWatch)
