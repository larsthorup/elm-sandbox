import Mouse
import Signal
import Keyboard
import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Time exposing (inSeconds, every, millisecond)
import Text
import Random

main = Signal.map view model

-- Model
model =
  Signal.foldp update (getRolls initialSeed) inputs

-- View
view (fiveRolls, seed) =
  collage 500 500 (renderRolls fiveRolls)

renderRolls = List.indexedMap renderRoll

renderRoll index roll =
  roll
    |> toString
    |> Text.fromString
    |> text
    |> move (10 * (toFloat index), 50)

-- Update
update action (fiveRolls, seed) =
  getRolls seed

getRolls seed =
  List.foldl roller ([], seed) [1, 2, 3, 4, 5]

roller index (someRolls, oldSeed) =
  let
    (roll, seed) = randomSide oldSeed
  in
    (roll :: someRolls, seed)

-- Signals
inputs = Mouse.clicks

-- Ports

-- Get an external input to use as seed for Random generator.
-- See the index.html for how that is done
-- port jsSeed : Int

initialSeed : Random.Seed
initialSeed = Random.initialSeed 4711

-- Remember this is a pure function, same input seed yields the same output (Int, Seed)
randomSide : Random.Seed -> (Int, Random.Seed)
randomSide seed =
  Random.generate (Random.int 1 6) seed