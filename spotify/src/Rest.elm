module Rest exposing (..)

import Http exposing (Error)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)
import Task
import Types exposing (..)
import Types exposing (..)


search : String -> Cmd Msg
search query =
    Http.get decodeAlbums (searchUrl query)
        |> Task.perform Err Ok
        |> Cmd.map SpotifyResponse


searchUrl : String -> String
searchUrl query =
    Http.url "https://api.spotify.com/v1/search"
        [ ( "q", query )
        , ( "type", "album" )
        , ( "market", "GB" )
        , ( "limit", "50" )
        ]


decodeAlbum : Decoder Album
decodeAlbum =
    decode Album
        |> required "id" string
        |> required "name" string
        |> required "images" (list decodeImage)


decodeImage : Decoder Image
decodeImage =
    "url" := string


decodeAlbums : Decoder (List Album)
decodeAlbums =
    at [ "albums", "items" ] (list decodeAlbum)
