import Control.Applicative
additionWithoutCarrying p1 p2 = takeWhile (/= -1) $ zipWith f (t p1) (t p2)
    where t = reverse . (++) (repeat 0) . map read . map pure . show
          f 0 0 = -1
          f a b = (a + b) `mod` 10

