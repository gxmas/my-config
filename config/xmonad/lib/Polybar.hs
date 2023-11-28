module Polybar
    ( polybar
    , togglePolybar
    , showPolybar
    , hidePolybar
    ) where

import XMonad
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import Colors

polybar :: StatusBarConfig
polybar = statusBarProp script (pure polybarPP)

togglePolybar :: X ()
togglePolybar = spawn "polybar-msg cmd toggle"

showPolybar :: X ()
showPolybar = spawn "polybar-msg cmd show"

hidePolybar :: X ()
hidePolybar = spawn "polybar-msg cmd hide"

polybarPP :: PP
polybarPP = def
    { ppCurrent         = wrapper blue
    , ppVisible         = wrapper gray
    , ppUrgent          = wrapper orange
    , ppHidden          = wrapper gray
    , ppHiddenNoWindows = wrapper red
    , ppTitle           = shorten 100 . wrapper purple
    }

script :: String
script = "/home/gnoel/.config/polybar/launch.sh"

wrapper :: String -> String -> String
wrapper c s
    | s /= "NSP" = wrap ("%{F" <> c <> "} ") "%{F-}" s
    | otherwise  = mempty
{-# INLINE wrapper #-}
