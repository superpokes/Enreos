sort' :: (Ord a) => [a] -> [a]
sort' [] = []
sort' (x:xs) = let smaller = [y | y <- xs, y < x]
                   bigger  = [z | z <- xs, z > x]
               in sort' smaller ++ [x] ++ sort' bigger
