module Task.Types exposing (Id, Model)

import Tag.Types as Tag exposing (..)


type alias Id =
    Int



-- , description : String
-- , tags : List Tag.Model


type alias Model =
    { name : String
    , start : Int
    , end : Int
    }


type Msg
    = AddTag
