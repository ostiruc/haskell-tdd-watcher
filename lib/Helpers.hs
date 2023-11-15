module Helpers where

import System.Environment
import System.Directory
import System.Process

endsWith :: String -> String -> Bool
endsWith pattern s
    | s == pattern = True
    | s == [] = False
    | otherwise = endsWith pattern (tail s)

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
