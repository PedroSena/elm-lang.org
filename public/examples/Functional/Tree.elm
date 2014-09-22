
{-----------------------------------------------------------------

Overview: A "Tree" represents a binary tree. A "Node" in a binary
tree always has two children. A tree can also be "Empty". Below
I have defined "Tree" and a number of useful functions.

This example also includes some challenge problems :)

-----------------------------------------------------------------}


data Tree a = Node a (Tree a) (Tree a) | Empty

empty : Tree a
empty = Empty

singleton : a -> Tree a
singleton v = Node v Empty Empty

insert : comparable -> Tree comparable -> Tree comparable
insert x tree =
  case tree of
    Empty -> singleton x
    Node y left right ->
      if x == y then tree else
      if x <  y then Node y (insert x left) right
                else Node y left (insert x right)

fromList : [comparable] -> Tree comparable
fromList xs = foldl insert empty xs

depth : Tree a -> Int
depth tree =
  case tree of
    Node v left right -> 1 + max (depth left) (depth right)
    Empty -> 0

map : (a -> b) -> Tree a -> Tree b
map f tree =
  case tree of
    Node v left right -> Node (f v) (map f left) (map f right)
    Empty -> Empty

t1 = fromList [1,2,3]
t2 = fromList [2,1,3]

main : Element
main = flow down [ display "depth" depth t1
                 , display "depth" depth t2
                 , display "map ((+)1)" (map ((+)1)) t2
                 ]

display : String -> (Tree a -> b) -> Tree a -> Element
display name f value =
    concat [ name, " (", show value, ") &rArr;\n    ", show (f value), "\n " ]
      |> toText
      |> monospace
      |> leftAligned
  

{-----------------------------------------------------------------

Exercises:

(1) Sum all of the elements of a tree.

       sum : Tree Number -> Number

(2) Flatten a tree into a list.

       flatten : Tree a -> [a]

(3) Check to see if an element is in a given tree.

       isElement : a -> Tree a -> Bool 

(4) Write a general fold function that acts on trees. The fold
    function does not need to guarantee a particular order of
    traversal.

       fold : (a -> b -> b) -> b -> Tree a -> b

(5) Use "fold" to do exercises 1-3 in one line each. The best
    readable versions I have come up have the following length
    in characters including spaces and function name:
      sum: 16
      flatten: 21
      isElement: 46
    See if you can match or beat me! Don't forget about currying
    and partial application!

(6) Can "fold" be used to implement "map" or "depth"?

(7) Try experimenting with different ways to traverse a
    tree: pre-order, in-order, post-order, depth-first, etc.
    More info at: http://en.wikipedia.org/wiki/Tree_traversal

-----------------------------------------------------------------}




