module State exposing (init, update)

import Types exposing (..)


init : Model
init =
    { value = 0 }


update message model =
    case message of
        Increment ->
            { model | value = model.value + 1 }

        Decrement ->
            { model | value = model.value - 1 }

        Change inputString ->
            case String.toInt inputString of
                Just inputValue ->
                    { model | value = inputValue }
                Nothing ->
                    { model | value = 0 }
