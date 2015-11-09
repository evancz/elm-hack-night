module TreeView where

import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Html
import Text
import Tree exposing (..)


draw : Float -> Tree a -> Html.Html
draw viewWidth tree =
  let
    (treeForm, depth) =
      treeToForm tree

    treeWidth =
      30 * 2^depth * 2

    scaleFactor =
      if treeWidth > viewWidth - 20 then
          viewWidth / treeWidth
      else
          1

    treeHeight =
      30 * depth * scaleFactor
  in
    Html.fromElement <|
      collage
        (round viewWidth)
        (round treeHeight + 40)
        [ treeForm
            |> scale scaleFactor
            |> move (0, treeHeight / 2)
        ]


treeToForm : Tree a -> (Form, Float)
treeToForm tree =
  case tree of
    Empty ->
        ( filled orange (oval 10 10)
        , 0
        )

    Node value left right ->
        let
          (leftForm, leftDepth) = treeToForm left
          (rightForm, rightDepth) = treeToForm right

          leftPoint = (-30 * 2^leftDepth, -30)
          rightPoint = (30 * 2^rightDepth, -30)

          treeForm =
            group
              [ segment (0,0) leftPoint
                  |> traced (solid black)
              , segment (0,0) rightPoint
                  |> traced (solid black)
              , oval 20 20
                  |> filled blue
              , toString value
                  |> Text.fromString
                  |> Text.color white
                  |> text
              , move leftPoint leftForm
              , move rightPoint rightForm
              ]
        in
          (treeForm, 1 + max leftDepth rightDepth)