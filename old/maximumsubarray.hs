-- El máximo de una sublista xs
maxSublist :: (Num a, Ord a) => [a] -> [a]
maxSublist [] = []
maxSublist (x:xs) = let f (mx, mxlst, lst) n = 
                        if mx > mx + n
                        then (mx, mxlist, lst ++ [n])
                        else (mx + n, lst ++ [n], lst ++ [n])
                    in foldl f (x, [x], [x]) xs
