module Main where

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
    _ <- createProcess (proc "cabal" ["test"]) { cwd = Just dir }
    return ()

main :: IO ()
main = do 
    pathToWatch <- resolvePathToWatch
    putStrLn ("Watching: " ++ pathToWatch)
    runTests pathToWatch
