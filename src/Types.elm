-- Types.elm


module Types exposing (Model, Msg(..))

import User.Types as User


type Msg
    = Increment
    | Decrement
    | Change String


type alias Model =
    { users : List User.Model }
