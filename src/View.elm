module View exposing (debugView)

-- import Types.Msg exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import User.View exposing (debugView)

debugView : Model -> Html msg
debugView model =
    div []
        [ text "Hello, world!"
        , br [] []
        , List.length model.users |> String.fromInt |> text
        , br [] []
        , User.View.viewAll model.users
        ]
