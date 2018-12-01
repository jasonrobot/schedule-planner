module User.View exposing (debugView, viewAll, rootView)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import User.Types exposing (..)

import Task.View -- exposing (debugView)



-- renderEach :  List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg


renderEach container containerAttrs itemRenderer list =
    container containerAttrs (List.map (\item -> text item) list)



-- List.map (\item -> element attrs [ renderer item ]) list


debugView : Model -> Html msg
debugView model =
    div []
        [ div [] [ text ("User: " ++ model.name) ]
        , div [] [ text "has these tasks:" ]
        , ul [ class "user__task-list" ]
            (List.map
                (\task -> Task.View.rootView task)
                model.tasks
            )
        ]

viewAll : List Model -> Html msg
viewAll models =
    div [ class "all-users" ] (List.map (\user -> debugView user) models)

rootView : Model -> Html msg
rootView model =
    div [ style "grid-row-end" (String.fromInt (List.length model.tasks))]
        [ text model.name ]
