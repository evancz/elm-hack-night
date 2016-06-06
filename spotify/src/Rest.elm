module Rest exposing (..)

import Http exposing (Error)
import Json.Decode as Decode exposing ((:=), Decoder)
import Task
import Types exposing (..)
import Types exposing (..)


search : String -> Cmd Msg
search query =
    Http.get decodeAnswers (searchUrl query)
        |> Task.perform Err Ok
        |> Cmd.map SpotifyResponse


searchUrl : String -> String
searchUrl query =
    Http.url "https://api.spotify.com/v1/search"
        [ ( "q", query )
        , ( "type", "album" )
        ]


decodeAnswers : Decoder (List Answer)
decodeAnswers =
    let
        albumName =
            Decode.map Answer ("name" := Decode.string)
    in
        (Decode.at [ "albums", "items" ] (Decode.list albumName))
