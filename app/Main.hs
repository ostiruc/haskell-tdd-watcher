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

mainLoop :: IO ()
mainLoop = do
    threadDelay 1000000
    putStrLn ("This is where tests should regularly run")
    mainLoop

main :: IO ()
main = do
    pathToWatch <- resolvePathToWatch
    putStrLn ("Watching: " ++ pathToWatch)
    runTests pathToWatch
    mainLoop
