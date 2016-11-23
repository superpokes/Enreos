module CiudadDelBarro where

import Control.Monad

data Node a = Empty | Node a deriving (Show)

instance Eq a => Eq (Node a) where
    Empty == Empty = True
    (Node x) == (Node y) = x == y
    _ == _ = False -- Either one or the other is Empty

instance Functor Node where
    fmap _ Empty = Empty
    fmap f (Node a) = Node (f a)



data Graph a = Graph { nodes :: [Node a], edges :: [(Node a,Node a)] }

test_graph = Graph { nodes = [Node 1, Node 2, Node 3, Node 4, Node 5], edges = [(Node 1, Node 2), (Node 1, Node 4), (Node 2, Node 4), (Node 4, Node 3), (Node 5, Node 4)] }

adjacent :: (Eq a) => Graph a -> Node a -> [Node a]
adjacent _ Empty = []
adjacent (Graph nodes edges) n = do
    edge <- edges
    guard $ sides edge
    return $ other edge
    where sides e = n == (fst e) || (n == (snd e))
          other e = if fst e == n then snd e else fst e

instance Functor Graph where
    fmap f (Graph ns es) = Graph (fmap (fmap f) ns) es


--instance Applicative Graph where
--    pure x =
--    Empty <*> g = Empty
--    Node f adj <*> g =
--
--instance Monad Graph where
--    return x = Node x []
--    fail _ = Empty
--    Empty >>= f = Empty
--    Node x adj >>= f = f x


--ciudadBarro :: Graph Int -> Graph Int
--ciudadBarro Empty = Empty


main :: IO ()
main = putStrLn ":)"

