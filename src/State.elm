module State exposing (init, update)

import Types exposing (..)
import User.Types as User


init : Model
init =
    { users =
        [ { name = "Foobar"
          , tasks = []
          }
        , { name = "Qwerty"
          , tasks = []
          }
        ]
    }


update : Msg -> Model -> Model
update message model =
    model
