module Tag.State exposing (init, update)

import Tag.Model exposing (..)


init : Model
init =
    { name = ""
    , color = "#ccc"
    }


update message model =
    case message of
        SetName str ->
            { model | name = str }

        SetColor str ->
            { model | color = str }
