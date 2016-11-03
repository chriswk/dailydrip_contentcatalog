module Styles.Variables exposing (..)

import Css exposing (..)


defaultPadding : Mixin
defaultPadding =
    padding (Css.rem 1)


primaryColor : Color
primaryColor =
    (rgb 230 100 230)


primaryTextColor : Color
primaryTextColor =
    rgb 255 255 255
