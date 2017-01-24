fibelem :: Int -> Int
fibelem 1 = 1
fibelem 2 = 2
fibelem x = (fibelem (x - 2)) + (fibelem (x - 1))

fibonacci :: [Int]
fibonacci = [fibelem x | x <- [1..] ]


