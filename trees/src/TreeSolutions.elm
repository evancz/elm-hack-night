module TreeSolutions where

{-- HEY DON'T CHEAT!!!!

This is for checking your answers.

--}

type Tree a
    = Empty
    | Node a (Tree a) (Tree a)


empty : Tree a
empty =
  Empty


singleton : a -> Tree a
singleton value =
  Node value Empty Empty


insert : comparable -> Tree comparable -> Tree comparable
insert newValue tree =
  case tree of
    Empty ->
      singleton newValue

    Node value left right ->
      if value == newValue then
          tree

      else if value < newValue then
          Node value (insert newValue left) right

      else
          Node value left (insert newValue right)


fromList : List comparable -> Tree comparable
fromList list =
  List.foldl insert empty list


depth : Tree a -> Int
depth tree =
  case tree of
    Empty ->
      0

    Node _ left right ->
      1 + max (depth left) (depth right)


map : (a -> b) -> Tree a -> Tree b
map func tree =
  case tree of
    Empty ->
      Empty

    Node value left right ->
      Node (func value) (map func left) (map func right)


sum : Tree number -> number
sum tree =
  case tree of
    Empty ->
      0

    Node value left right ->
      value + sum left + sum right


flatten : Tree a -> List a
flatten tree =
  case tree of
    Empty ->
      []

    Node value left right ->
      flatten left ++ [value] ++ flatten right


contains : a -> Tree a -> Bool
contains val tree =
  case tree of
    Empty ->
      False

    Node value left right ->
      if value == val then
          True

      else if val < value then
          contains val left

      else
          contains val right


fold : (a -> b -> b) -> b -> Tree a -> b
fold func accumulator tree =
  case tree of
    Empty ->
      accumulator

    Node value left right ->
      fold func (func value (fold func accumulator left)) right


{-- CODE GOLF

sum = fold (+) 0
flatten = fold (++) []
contains x = fold (\y b -> b || x == y) False
contains x = fold (||) False << map ((==) x)

--}


{-- (6) Can "fold" be used to implement "map" or "depth"?

No.

--}
