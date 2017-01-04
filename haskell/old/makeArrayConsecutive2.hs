makeArrayConsecutive2 sequence = 
    foldl f 0 [(minimum sequence + 1)..(maximum sequence - 1)]
    where f x acc = if x `elem` sequence then acc else acc + 1
