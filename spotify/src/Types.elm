module Types exposing (..)

import Http exposing (Error)


type alias Answer =
    { name : String
    }


type alias Model =
    { query : String
    , results : Maybe (Result Error (List Answer))
    }


type Msg
    = QueryChange String
    | Query
    | SpotifyResponse (Result Error (List Answer))
