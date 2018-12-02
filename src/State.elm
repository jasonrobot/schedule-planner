module State exposing (init, update)

import Types exposing (..)
import User.Types as User


init : Model
init =
    { users =
        [ { name = "Foobar"
          , tasks =
                [ { name = "Task 1"
                  , start = 10
                  , end = 20
                  }
                -- , { name = "Task 2"
                --   , start = 15
                --   , end = 30
                --   }
                ]
          }
        , { name = "Qwerty"
          , tasks =
                [ { name = "Task 3"
                  , start = 5
                  , end = 45
                  }
                ]
          }
        ]
    }


update : Msg -> Model -> Model
update message model =
    model
