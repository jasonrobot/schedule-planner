-- App.elm
-- Logic and functions

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Types exposing (..)
import State exposing (..)
import View exposing (..)

main =
    Browser.sandbox
        { init = State.init
        , update = State.update
        , view = View.rootView
        }
