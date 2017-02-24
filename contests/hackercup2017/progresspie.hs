import Control.Monad

type Point = (Int, Int)
type Percentage = Double

isBlack :: Percentage -> Point -> Bool
isBlack p (x,y) = let progressAngle = 2 * pi * p
                      (relX,relY) = (fromIntegral x-50,fromIntegral y-50)
                      pointDistance = sqrt (relX * relX + relY * relY)
                      quadrant
                        | relX > 0 && relY > 0 = 1
                        | relX < 0 && relY > 0 = 2
                        | relX < 0 && relY < 0 = 3
                        | otherwise = 4
                      pointAngle = atan (relY / relX) * quadrant
    in pointDistance < 50 && pointAngle > 0 && pointAngle < progressAngle

parsePoints :: [String] -> [(Int, (Percentage, Point))]
parsePoints input = foldr addIndex [] (map parsePoint input)
    where parsePoint stringPoint = let separated = words stringPoint
                                       (p,x,y) = ("0."++ head separated,separated !! 1,separated !! 2)
                                       in (read p, (read x, read y))
          addIndex x acc = (length input - length acc,x):acc

printColor :: (Int,(Percentage,Point)) -> IO ()
printColor (index,(perc,point)) =
    putStrLn $ "Case #" ++ show index ++ ": " ++ if isBlack perc point
                                                then "black"
                                                else "white"

main :: IO ()
main = do
    pointAmount <- getLine
    points <- replicateM (read pointAmount) getLine
    mapM_ printColor (parsePoints points)
