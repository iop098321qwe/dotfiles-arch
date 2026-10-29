-- Keep only your personal input overrides here. Uncommented settings below
-- replace Omarchy's defaults.

-- Keyboard layout and options.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
  input = {
    -- Keep US/German layouts. No toggle is needed during the 4.0 transition;
    -- inherit SUPER+I / SUPER+SHIFT+I input cycling after upgrading to 4.5.
    kb_layout = "us, de",
    -- TODO: (omarchy-4.5) Adapt stock shifted Compose to the swapped keys using
    -- a user-owned XKB definition: physical CAPS -> Escape, physical ESC ->
    -- Caps Lock, physical SHIFT+ESC -> Compose without toggling Caps Lock.
    -- Stock omarchy:shift_caps_compose targets physical CAPS; do not merely
    -- combine it with caps:swapescape or assume the swap redirects Compose.
    -- Back up affected files first. Once the replacement works, remove
    -- compose:rctrl so Right Ctrl is normal; retain both-Shifts Caps cancel.
    -- Validate the swap, Caps Lock state, Compose sequences, and Right Ctrl
    -- in BOTH US/German layouts before removing this TODO. Keep this explicit
    -- override rather than inheriting defaults that would discard the swap.
    -- Right Alt dictation/German AltGr overlap is intentionally accepted.
    kb_options = "caps:swapescape,shift:both_capslock_cancel,compose:rctrl",

    -- Use a specific keyboard variant if needed (e.g. intl for international keyboards).
    -- kb_variant = "intl",

    -- Change speed of keyboard repeat.
    repeat_rate = 40,
    repeat_delay = 250,

    -- Start with numlock on by default.
    numlock_by_default = true,

    -- Increase sensitivity for mouse/trackpad (default: 0).
    sensitivity = 0.35,

    -- Turn off mouse acceleration (default: adaptive).
    accel_profile = "flat",

    touchpad = {
      -- Use natural (inverse) scrolling.
      natural_scroll = true,

      -- Use two-finger clicks for right-click instead of lower-right corner.
      clickfinger_behavior = true,

      -- Control the speed of your scrolling.
      scroll_factor = 0.4,

      -- Disable the touchpad while typing.
      disable_while_typing = true,

      -- Left-click-and-drag with three fingers.
      drag_3fg = 1,
    },
  },
})

-- App-specific touchpad scroll speeds.
o.window("(Alacritty|kitty|foot)", { scroll_touchpad = 1.5 })
o.window("com.mitchellh.ghostty", { scroll_touchpad = 0.2 })

-- Enable touchpad gestures for changing workspaces.
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Enable touchpad gestures for moving focus (helpful on scrolling layout).
-- hl.gesture({ fingers = 3, direction = "left", action = function() hl.dispatch(hl.dsp.focus({ direction = "l" })) end })
-- hl.gesture({ fingers = 3, direction = "right", action = function() hl.dispatch(hl.dsp.focus({ direction = "r" })) end })
