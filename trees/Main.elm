
import Html exposing (..)
import Tree
import TreeView


myTree =
    Tree.empty


main : Html
main =
    TreeView.draw 800 myTree