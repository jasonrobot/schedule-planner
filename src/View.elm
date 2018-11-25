module View exposing (rootView)

-- import Types.Msg exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


rootView model =
    div [ class "form" ]
        [ div [ class "value-input" ]
            [ input [ value (String.fromInt model.value), onInput Types.Change ] []
            ]
        , div [ class "value-buttons" ]
            [ button [ onClick Types.Decrement ] [ text "-" ]
            , button [ onClick Types.Increment ] [ text "+" ]
            ]
        ]
