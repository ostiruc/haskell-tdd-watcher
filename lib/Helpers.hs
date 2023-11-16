module Helpers where

import System.Environment
import System.Directory
import System.Process

endsWith :: String -> String -> Bool
endsWith pattern s
    | s == pattern = True
    | s == [] = False
    | otherwise = endsWith pattern (tail s)

removeSuffix :: String -> String -> String
removeSuffix suffix str
    | str == suffix = []
    | str == [] = []
    | otherwise = (head str) : (removeSuffix suffix (tail str))

resolvePathToWatch :: IO String
resolvePathToWatch = do
    args <- getArgs
    path <- (makeAbsolute (head args))
    return (removeSuffix "/" path)

runTests :: String -> IO ()
runTests dir = do 
    putStrLn "\n*** TEST RUN ***\n"
    output <- readCreateProcess (proc "cabal" ["test"]) { cwd = Just dir } ""
    putStrLn output
    putStrLn "\n*** TEST COMPLETE ***\n"

filesUnderPath :: String -> [String] -> IO [String] 
filesUnderPath filePath ignores= do 
    isDir <- doesDirectoryExist filePath
    if isDir then do
        filesUnderPaths [filePath] ignores
    else
        return []

filesUnderPaths :: [String] -> [String] -> IO [String]
filesUnderPaths [] _ = return []
filesUnderPaths (fp:fps) ignores = do
    isDir <- doesDirectoryExist fp
    isFile <- doesFileExist fp
    if isDir then do
        dirContents <- getDirectoryContents fp
        let
            subContents = map (\x -> fp ++ "/" ++ x) filteredContents
            filteredContents = (foldr (\x acc -> filter (/= x) acc) dirContents ignores)
        filesUnderPaths (subContents ++ fps) ignores
    else if isFile then do
        fpsFiles <- filesUnderPaths fps ignores
        return (fp:fpsFiles)
    else
        filesUnderPaths fps ignores

hasChanges :: [String] -> IO Bool
hasChanges (filePath:_) = do
    isDir <- doesDirectoryExist filePath
    if isDir then do
        dirContents <- getDirectoryContents filePath
        print dirContents
        hasChanges [filePath ++ "imaginary-file.hs"]
    else if endsWith ".hs" filePath then do
        putStrLn ("Found .hs file: " ++ filePath)
        return True
    else
        return False
