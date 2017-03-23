module SequenceSolver where

next :: [Int] -> Int
next s
    | converges diffs = last s + head diffs
    | otherwise = last s + next diffs
    where diffs = difference s

difference :: [Int] -> [Int]
difference [] = []
difference [x] = [x]
difference [a, b] = [b - a]
difference (a:b:rest) = (b - a):difference (b:rest)

converges :: [Int] -> Bool
converges [] = undefined
converges [_] = True
converges (a:b:_) = a == b
