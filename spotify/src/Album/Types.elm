module Album.Types exposing (..)


type alias Image =
    String


type alias Model =
    { id : String
    , name : String
    , images : List Image
    , showDetails : Bool
    }


type Msg
    = ToggleDetails
