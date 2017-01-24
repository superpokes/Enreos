quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (first:rest) = 
  let smaller = quicksort [a | a <- rest, a <= first]
      bigger = quicksort [a | a <- rest, a > first]
  in smaller ++ [first] ++ bigger
