module Helpers where

import Data.Time
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
    let pathArg = if args /= [] then head args else "."
    path <- makeAbsolute pathArg
    return (removeSuffix "/" path)

runTests :: String -> IO ()
runTests dir = do 
    putStrLn "\n*** TEST RUN ***\n"
    (_, stdout, _) <- readCreateProcessWithExitCode (proc "cabal" ["test"]) { cwd = Just dir } ""
    putStr stdout
    putStrLn "\n*** TEST COMPLETE ***\n"

data WatchedFile = WatchedFile { 
    filePath :: String, 
    timeStamp :: UTCTime 
} deriving (Show, Eq)

watchFiles :: [String] -> IO [WatchedFile]
watchFiles [] = return []
watchFiles (fp:fps) = do
    timeStamp <- getModificationTime fp
    watchedFiles <- watchFiles fps
    return ((WatchedFile fp timeStamp):watchedFiles)

filesUnderPath :: String -> [String] -> IO [String] 
filesUnderPath filePath ignores = do 
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
