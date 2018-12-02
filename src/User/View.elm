module User.View exposing (debugView, rootView, viewAll)

-- exposing (debugView)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Task.Types
import Task.View
import User.Types exposing (..)



-- renderEach :  List (Html.Attribute msg) -> List (Html.Html msg) -> Html.Html msg


renderEach container containerAttrs itemRenderer list =
    container containerAttrs (List.map (\item -> text item) list)



-- List.map (\item -> element attrs [ renderer item ]) list


debugView : Model -> Html msg
debugView model =
    div []
        [ div [] [ text ("User: " ++ model.name) ]
        , div [] [ text "has these tasks:" ]
        , ul [ class "user__task-list" ]
            (List.map
                -- (\task -> Task.View.rootView task)
                (\task -> text task.name)
                model.tasks
            )
        ]


viewAll : List Model -> Html msg
viewAll models =
    div [ class "all-users" ] (List.map (\user -> debugView user) models)


rootView : Model -> Html msg
rootView model =
    div
        [ style "grid-row-end" (String.append "span " (String.fromInt (List.length model.tasks)))
        , class "user"
        ]
        [ text model.name ]


type alias Task =
    Task.Types.Model


type alias TaskRow =
    List Task


type alias UserRow =
    List TaskRow


canFitInTaskRow : Task -> TaskRow -> Bool
canFitInTaskRow task taskRow =
    List.any (\t -> (task.start > t.start) && (task.start < t.end)) taskRow


addTaskToUserRow : Task -> UserRow -> TaskRow
addTaskToUserRow task userRow =
    case List.filter (\tr -> canFitInTaskRow task tr) userRow |> List.head of
        Just tr ->
            task :: tr

        Nothing ->
            [ task ]


foo : Task -> UserRow -> UserRow
foo task userRow =
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



-- renderTasks : Model -> List (Html msg)
-- renderTasks model =
