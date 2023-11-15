module Main where

import Control.Concurrent
import System.Environment
import System.Directory
import System.Process

resolvePathToWatch :: IO String
resolvePathToWatch = do
    args <- getArgs
    path <- (makeAbsolute (head args))
    return path

runTests :: String -> IO ()
runTests dir = do 
    putStrLn "\n*** TEST RUN ***\n"
    output <- readCreateProcess (proc "cabal" ["test"]) { cwd = Just dir } ""
    putStrLn output
    putStrLn "\n*** TEST COMPLETE ***\n"

endsWith :: String -> String -> Bool
endsWith pattern s
    | s == pattern = True
    | s == [] = False
    | otherwise = endsWith pattern (tail s)

hasChanges :: String -> IO Bool
hasChanges filePath = do
    isDir <- doesDirectoryExist filePath
    if isDir then do
        dirContents <- getDirectoryContents filePath
        print dirContents
        hasChanges (filePath ++ "imaginary-file.hs")
    else if endsWith ".hs" filePath then do
        putStrLn ("Found .hs file: " ++ filePath)
        return True
    else
        return False

mainLoop :: String -> IO ()
mainLoop pathToWatch = do
    threadDelay 1000000
    hasChanges <- hasChanges pathToWatch
    if hasChanges then runTests pathToWatch else putStrLn ("skipped")
    mainLoop pathToWatch

main :: IO ()
main = do
    pathToWatch <- resolvePathToWatch
    putStrLn ("Watching: " ++ pathToWatch)
    runTests pathToWatch
    mainLoop pathToWatch
