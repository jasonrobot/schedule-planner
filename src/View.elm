module View exposing (debugView, rootView)

-- import Types.Msg exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task.View exposing (debugView, rootView)
import Types exposing (..)
import User.View exposing (debugView, rootView)


debugView : Model -> Html msg
debugView model =
    div []
        [ text "Hello, world!"
        , br [] []
        , List.length model.users |> String.fromInt |> text
        , br [] []
        , User.View.viewAll model.users
        ]


renderSearch : Html msg
renderSearch =
    div [ class "search" ] [ text "Search!" ]


renderMonths : Model -> List (Html msg)
renderMonths model =
    List.map
        (\month -> div [ class "month" ] [ text month ])
        [ "January"
        , "February"
        , "March"
        , "April"
        ]


renderUsers : Model -> List (Html msg)
renderUsers model =
    List.map2
        (\user startRow -> User.View.rootView user startRow)
        model.users
        (User.View.getRows model.users)
        |> List.concat



-- todo render the header at some point in here


rootView : Model -> Html msg
rootView model =
    div [ class "app-grid" ]
        (List.concat
            [ [ renderSearch ]
            , renderMonths model
            , renderUsers model

            -- , renderTasks model
            ]
        )
