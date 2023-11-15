module Helpers where

endsWith :: String -> String -> Bool
endsWith pattern s
    | s == pattern = True
    | s == [] = False
    | otherwise = endsWith pattern (tail s)
