module User.View exposing (rootView, viewAll)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import User.Types exposing (..)



-- renderEach :  List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg


renderEach container containerAttrs itemRenderer list =
    container containerAttrs (List.map (\item -> text item) list)



-- List.map (\item -> element attrs [ renderer item ]) list


rootView : Model -> Html msg
rootView model =
    div []
        [ div [] [ text ("User: " ++ model.name) ]
        , div [] [ text "has these tasks:" ]
        , ul [ class "user__task-list" ]
            (List.map
                (\task -> li [ class "user__task" ] [ text task.name ])
                model.tasks
            )
        ]

viewAll : List Model -> Html msg
viewAll models =
    div [ class "all-users" ] (List.map (\user -> rootView user) models)
