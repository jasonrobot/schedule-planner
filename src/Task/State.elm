module Task.State exposing (init, update)

import Task.Types exposing (..)


init : Model
init =
    { id = 69
    , name = ""
    , description = ""
    , tags = []
    }

{--
update message model =
    case message of

--}
