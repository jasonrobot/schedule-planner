module User.View exposing (rootView)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import User.Types exposing (..)


rootView : Model -> Html msg
rootView model =
    div []
        [ div [] [ text ("User: " ++ model.name) ]
        , div [] [ text "has these tasks:" ]
        , ul []
            (List.map (\task -> li [] [ text task.name ]) model.tasks)
        ]
