module Task.Types exposing (Model, Id)

import Tag.Types as Tag exposing (..)

type alias Id = Int

type alias Model =
    { id : Id
    , name : String
    , description : String
    , tags : List Tag.Model
    }

type Msg
    = AddTag
