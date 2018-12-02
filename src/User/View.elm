module User.View exposing (debugView, rootView, getRows, viewAll)

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
            theRows =
                -- UserRow
                Task.View.buildUserRow model.tasks
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


-- usersToStartRows : List Model -> List Int
-- usersToStartRows users =
--     List.indexedMap
--         (\index user -> (List.length (Task.View.buildUserRow user.tasks)) + index - 1)
--         -- (\index user -> (List.length user.tasks) + index - 1)
--         users
--     List.map

getRowsR : List Model -> Int -> List Int
getRowsR users startRow =
    case List.head users of
        Nothing -> [startRow]
        Just user -> startRow :: getRowsR (List.drop 1 users) (startRow + (List.length user.tasks))

getRows : List Model -> List Int
getRows users =
    getRowsR users 1
