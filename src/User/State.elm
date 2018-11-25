module User.State exposing (init, update)

init : String -> Model
init _name =
    { name = _name
    , tasks = []
    }

update : Msg -> Model -> Model
update message model =
    case message of
        AddTask task ->
            { model | task :: model.tasks }
        _ ->
            model
