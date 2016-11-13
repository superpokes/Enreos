digitSum n = foldl (+) 0 cosas
             where cosas = map (read . pure) (show n)
