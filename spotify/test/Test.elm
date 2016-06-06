module Test exposing (main)

{-| The main entry point for the tests.

@docs main
-}

import ElmTest exposing (..)


tests : Test
tests =
    suite "All" []


{-| Run the test suite under node.
-}
main : Program Never
main =
    runSuite tests
