coins = [50,20,10,5,2,1]

givechange :: Integer -> [Integer] -> [Integer]
givechange 0 _ = []
givechange n xs = let f (ys,price) coin = if price >= coin then f (coin:ys,price-coin) coin else (ys,price)
                  in fst $ foldl f ([],n) xs
