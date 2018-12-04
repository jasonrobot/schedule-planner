module Task.View exposing (debugView, rootView, buildUserRow)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task.Types exposing (..)


rootView : Task.Types.Model -> Int -> Html msg
rootView model row =
    div
        [ class "task"
        , style "grid-row" "2"
        , style "grid-column-start" (String.fromInt model.start)
        , style "grid-column-end" (String.fromInt model.end)
        ]
        [ text model.name ]


debugView : Task.Types.Model -> Html msg
debugView model =
    div [] [ text model.name ]


type alias Task =
    Task.Types.Model


type alias TaskRow =
    List Task


type alias UserRow =
    List TaskRow


taskInSameRange : Task -> Task -> Bool
taskInSameRange t1 t2 =
    (t1.start > t2.start)
        && (t1.start < t2.end)
        && (t2.start > t1.start)
        && (t2.start < t1.end)


canFitInTaskRow : Task -> TaskRow -> Bool
canFitInTaskRow task taskRow =
    List.any (taskInSameRange task) taskRow


addTaskToUserRow : Task -> UserRow -> UserRow
addTaskToUserRow task userRow =
    let
        ( fittingRows, otherRows ) =
            -- (TaskRow, TaskRow)
            List.partition (\tr -> canFitInTaskRow task tr) userRow
    in
    case List.head fittingRows of
        Just row ->
            -- add to existing row
            (task :: row) :: List.drop 1 fittingRows ++ otherRows

        Nothing ->
            -- just add this task in a new row
            [ task ] :: userRow


buildUserRow : List Task -> UserRow
buildUserRow tasks =
    List.foldl (\task -> addTaskToUserRow task) [] tasks
