-- Tatiana likes to keep things tidy. Her toys are sorted from smallest to
-- largest, her pencils are sorted from shortest to longest and her computers
-- from oldest to newest. One day, when practicing her counting skills, she
-- noticed that some integers, when written in base 10 with no leading zeroes,
-- have their digits sorted in non-decreasing order. Some examples of this are
-- 8, 123, 555, and 224488. She decided to call these numbers tidy. Numbers that
-- do not have this property, like 20, 321, 495 and 999990, are not tidy.
--
-- She just finished counting all positive integers in ascending order from 1
-- to N. What was the last tidy number she counted?

import Control.Monad (replicateM)

digits :: Int -> [Int]
digits 0 = []
digits n = (n `mod` 10):digits (n `div` 10)

fromDigits :: [Int] -> Int
fromDigits [] = 0
fromDigits (d:ds) = d + 10 * fromDigits ds

nonIncreasing :: [Int] -> Maybe Int
nonIncreasing xs =
    case length xs' of
        _ | length xs' == l - 1 -> Nothing
        l' -> Just $ l' + 1
    where
        xs' = takeWhile (uncurry (<=)) (zip (tail xs) xs)
        l = length xs

lastTidy :: Int -> Int
lastTidy n =
    case nonIncreasing ds of
        Nothing -> n
        Just i -> lastTidy . fromDigits . new $ i
    where
        ds = digits n
        new i = replicate i 9 ++ ((ds !! i) - 1):drop (i + 1) ds

format :: (Int, Int) -> String
format (i, n) = "Case #" ++ show i ++ ": " ++ show n

main :: IO ()
main = do
    cases <- fmap read getLine
    tidies <- replicateM cases (fmap (lastTidy . read) getLine)
    mapM_ (putStrLn . format) (zip [1..] tidies)
