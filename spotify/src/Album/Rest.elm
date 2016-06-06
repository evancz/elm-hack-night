module Album.Rest exposing (..)

import Album.Types exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


decodeAlbum : Decoder Model
decodeAlbum =
    decode Model
        |> required "id" string
        |> required "name" string
        |> required "images" (list decodeImage)
        |> hardcoded False


decodeImage : Decoder Image
decodeImage =
    "url" := string
