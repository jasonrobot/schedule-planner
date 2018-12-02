module User.View exposing (debugView, rootView, viewAll, usersToStartRows)

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


rootView : Model -> Int -> List (Html msg)
rootView model startRowIndex =
    (::)
        (div
            [ style "grid-row-start" (String.fromInt (startRowIndex + 1))
            , style "grid-row-end" (String.append "span " (String.fromInt (List.length model.tasks)))
            , class "user"
            , class (String.fromInt startRowIndex)
            ]
            [ text model.name ]
        )
        (let
            userRow =
                [ [] ]

            theRows =
                -- UserRow
                List.foldr (\task -> addTaskToUserRow task) userRow model.tasks
         in
         List.indexedMap
            (\index taskRow ->
                List.map
                    (\task ->
                        div
                            [ class (String.fromInt index)
                            , style "grid-column-start" (String.fromInt task.start)
                            , style "grid-column-end" (String.fromInt task.end)
                            , style "grid-row-start" (String.fromInt (startRowIndex + index + 1))
                            ]
                            [ text task.name ]
                    )
                    taskRow
            )
            theRows
            |> List.concat
        )


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


usersToStartRows : List Model -> List Int
usersToStartRows users =
    List.indexedMap
        (\index user -> (List.length (List.foldl (\task -> addTaskToUserRow task) [] user.tasks)) + index)
        users
