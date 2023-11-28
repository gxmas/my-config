import XMonad
import qualified XMonad.StackSet as W

-- Hooks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName (setWMName)
import XMonad.Hooks.StatusBar (withSB)

-- Layout
import XMonad.Layout.LayoutModifier
import XMonad.Layout.MultiToggle (Toggle(..), mkToggle, single)
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL))
import XMonad.Layout.NoBorders (smartBorders)
import XMonad.Layout.Renamed (Rename(Replace), renamed)
import XMonad.Layout.ResizableThreeColumns
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing

-- Util
import XMonad.Util.Cursor
import XMonad.Util.EZConfig
import XMonad.Util.NamedScratchpad
import XMonad.Util.SpawnOnce

-- Misc
import qualified Data.Map as M
import System.Exit

import Polybar

main :: IO ()
main = xmonad $ withSB polybar . ewmh .docks $ def
    { normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , terminal           = myTerminal
    , layoutHook         = myLayoutHook
    , manageHook         = myManageHook
    , modMask            = myModMask
    , keys               = myKeys
    , borderWidth        = myBorderWidth
    , startupHook        = myStartupHook
    , focusFollowsMouse  = True
    }

myModMask :: KeyMask
myModMask = mod4Mask

myTerminal :: String
myTerminal = "alacritty"

myBorderWidth :: Dimension
myBorderWidth = 3

myNormalBorderColor :: String
myNormalBorderColor = "#1ba6fa"

myFocusedBorderColor :: String
myFocusedBorderColor = "#ebebeb"

myWallpaper :: String
myWallpaper = "~/.local/share/wallpapers/weiwei-pink.jpg"

appLauncher = "rofi -modi drun -show drun -show-icons"

--------------------------------------------------------------------------
--  LayoutHook
--------------------------------------------------------------------------
myLayoutHook = avoidStruts
             $ fullScreenToggle
             $ tall ||| Mirror tall ||| threeColMid ||| Full
  where
    fullScreenToggle = mkToggle (single NBFULL)

    tall = renamed [Replace "Tall"]
         $ spacingRaw True (sqbdr 8) True (sqbdr 8) True
         $ ResizableTall 1 (3/100) (1/2) []

    threeColMid = renamed [Replace "3Col-Mid"]
                $ spacingRaw True (sqbdr 8) True (sqbdr 8) True
                $ ResizableThreeColMid 1 (3/100) (1/2) []

    sqbdr n = Border n n n n

--------------------------------------------------------------------------
--  ManageHook
--------------------------------------------------------------------------
myManageHook :: ManageHook
myManageHook = composeOne
    [ isDialog           -?> doFloat
    , className =? "mpv" -?> doCenterFloat
    ]
    <+>
    namedScratchpadManageHook myScratchpads

--------------------------------------------------------------------------
--  StartupHook
--------------------------------------------------------------------------
myStartupHook :: X ()
myStartupHook =
            spawnOnce ("xwallpaper --zoom " ++ myWallpaper)
        <+> spawnOnce "picom -b"
        -- <+> setDefaultCursor xC_left_ptr
        <+> spawnOnce "xbanish"
        <+> setWMName "LG3D"

--------------------------------------------------------------------------
--  Named Scratchpads
--------------------------------------------------------------------------
myScratchpads :: [NamedScratchpad]
myScratchpads = [ NS "terminal" spawnTerm findTerm manageTerm
                ]
    where
        spawnTerm = myTerminal ++ " -t scratchpad"
        findTerm  = title =? "scratchpad"
        manageTerm =
            let x = (1-w)/2
                y = (1-h)/2
                w = 0.75
                h = 0.75
            in customFloating $ W.RationalRect x y w h

--------------------------------------------------------------------------
--  Key Bindings
--------------------------------------------------------------------------
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf = mkKeymap conf $
    [ ("M-S-<Return>", spawn $ terminal conf)
    , ("M-p"         , spawn appLauncher)
    , ("M-S-c"       , kill)

    , ("M-<Space>"   , sendMessage NextLayout)
    , ("M-S-<Space>" , setLayout $ layoutHook conf)
    , ("M-f"         , sendMessage (Toggle NBFULL) >> togglePolybar)
    , ("M-b"         , togglePolybar)

    , ("M-n"         , refresh)

    , ("M-<Tab>"     , windows W.focusDown)
    , ("M-S-<Tab>"   , windows W.focusUp)
    , ("M-m"         , windows W.focusMaster)

    , ("M-<Return>"  , windows W.swapMaster)
    , ("M-j"         , windows W.swapDown)
    , ("M-k"         , windows W.swapUp)

    , ("M-S-h"       , sendMessage Shrink)
    , ("M-S-l"       , sendMessage Expand)
    , ("M-S-j"       , sendMessage MirrorShrink)
    , ("M-S-k"       , sendMessage MirrorExpand)

    , ("M-s t"       , namedScratchpadAction myScratchpads "terminal")

    , ("M-t"         , withFocused $ windows . W.sink)

    , ("M-,"         , sendMessage (IncMasterN 1))
    , ("M-."         , sendMessage (IncMasterN (-1)))

    , ("M-S-q"       , io exitSuccess)
    , ("M-q"         , spawn "if type xmonad; then xmonad --recompile && xmonad --restart; fi")
    ]
    ++
    [ (m ++ k, windows $ f i)
        | (i, k) <- zip (workspaces conf) (map show [1..9])
        , (f, m) <- [ (W.greedyView, "M-"), (W.shift, "M-S-")]
    ]
    ++
    [ (m ++ k, screenWorkspace s >>= flip whenJust (windows . f))
        | (k, s) <- zip [ "w", "e", "r" ] [0..]
        , (f, m) <- [ (W.view, "M-"), (W.shift, "M-S-") ]
    ]
    ++
    [ ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")
    , ("<XF86AudioMute>"       , spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ("<XF86WLAN>"            , return ())
    ]
