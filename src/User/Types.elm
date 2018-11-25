module User.Types exposing (Model)

import Task.Types as Task exposing (..)

type alias Model =
    { name : String
    , tasks : List Task.Model
    }

type Msg
    = AddTask Task.Model
    | RemoveTask Task.Id
