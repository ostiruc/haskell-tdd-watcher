module Main where

import Control.Concurrent

import Helpers

mainLoop :: String -> [WatchedFile] -> IO ()
mainLoop pathToWatch filesBefore = do
    threadDelay 1000000
    files <- filesUnderPath pathToWatch [".", "..", "dist-newstyle", ".git"]
    filesAfter <- watchFiles (filter (endsWith ".hs") files)
    if filesBefore /= filesAfter then 
        runTests pathToWatch 
    else 
        putStrLn ("skipped")
    mainLoop pathToWatch filesAfter

main :: IO ()
main = do
    pathToWatch <- resolvePathToWatch
    putStrLn ("Watching: " ++ pathToWatch)
    files <- filesUnderPath pathToWatch [".", "..", "dist-newstyle", ".git"]
    filesBefore <- watchFiles (filter (endsWith ".hs") files)

    runTests pathToWatch
    mainLoop pathToWatch filesBefore
