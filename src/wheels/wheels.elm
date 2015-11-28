import Mouse
import Signal
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (show)

cartesianX : Int -> Int -> Float
cartesianX x width =
  x - (width // 2) |> toFloat

cartesianY : Int -> Int -> Float
cartesianY y height =
  (height // 2) - y |> toFloat

cartesian : (Int, Int) -> (Int, Int) -> (Float, Float)
cartesian (x, y) (width, height) =
  (cartesianX x width, cartesianY y height)

someShape color deg mouseX mouseY =
  let
    x = cartesianX mouseX 500
    y = cartesianY mouseY 500
  in ngon 5 50.0
    |> filled color
    |> alpha 0.8
    |> scale 2.5
    |> move (x, y)
    |> rotate (degrees (x * deg))

view x y =
  collage 500 500 [ someShape red 45 x y, someShape green 55 x y]

main =
  Signal.map2 view Mouse.x Mouse.y