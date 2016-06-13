module Main exposing (..)

import Html exposing (..)
import Tree
import TreeView


myTree =
    Tree.empty


main : Html msg
main =
    TreeView.draw 800 myTree
