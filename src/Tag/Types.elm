module Tag.Types exposing (Model, Msg)


type alias Model =
    { name : String
    , color : String
    }


type Msg
    = SetName String
    | SetColor String
