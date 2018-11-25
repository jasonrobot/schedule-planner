-- Types.elm


module Types exposing (Model, Msg(..))


type Msg
    = Increment
    | Decrement
    | Change String


type alias Model =
    { value : Int }
