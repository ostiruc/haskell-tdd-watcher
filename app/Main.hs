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
    files <- filesUnderPath pathToWatch [".", "..", "dist-newstyle", ".git"]
    --print $ files
    let hsFiles = filter (endsWith ".hs") files
    print $ hsFiles

    -- runTests pathToWatch
    -- mainLoop pathToWatch
