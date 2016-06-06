module Rest exposing (..)

import Album.Rest as Album
import Album.Types as Album
import Array exposing (Array)
import Http exposing (Error)
import Json.Decode exposing (..)
import Task
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


decodeAlbums : Decoder (Array Album.Model)
decodeAlbums =
    at [ "albums", "items" ] (array Album.decodeAlbum)
