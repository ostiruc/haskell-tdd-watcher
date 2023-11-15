module Main where

import Control.Concurrent

import Helpers


mainLoop :: String -> IO ()
mainLoop pathToWatch = do
    threadDelay 1000000
    hasChanges <- hasChanges [pathToWatch]
    if hasChanges then 
        runTests pathToWatch 
    else 
        putStrLn ("skipped")
    mainLoop pathToWatch

main :: IO ()
main = do
    pathToWatch <- resolvePathToWatch
    putStrLn ("Watching: " ++ pathToWatch)
    runTests pathToWatch
    mainLoop pathToWatch
