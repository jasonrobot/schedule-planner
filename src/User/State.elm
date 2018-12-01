module User.State exposing (init, update)

init : String -> Model
init _name =
    { name = _name
    , tasks = []
    }

getAllTasks : List Model -> List Task.Model
getAllTasks users =
    map (\user -> user.tasks) users \> flatten

update : Msg -> Model -> Model
update message model =
    case message of
        AddTask task ->
            { model | task :: model.tasks }
        _ ->
            model
