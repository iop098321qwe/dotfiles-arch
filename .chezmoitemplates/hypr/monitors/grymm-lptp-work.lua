-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

-- Monitor scale is Hyprland's scale for the output. It sizes everything
-- Wayland-native, accepts fractions (1.6, 1.75), and applies immediately.
-- "auto" lets Hyprland pick per display.
local omarchy_monitor_scale = "auto"
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- Laptop Display
hl.monitor({
  output = "desc:InfoVision Optoelectronics (Kunshan) Co.Ltd China 0x3D41 0x00000004",
  mode = "preferred",
  position = "auto-right",
  scale = 1,
})

-- External Display (Samsung Odyssey G7)
hl.monitor({
  output = "desc:Samsung Electric Company LC27G7xT H4ZR703280",
  mode = "2560x1440@120",
  position = "auto-right",
  scale = omarchy_monitor_scale,
})

-- External Display (Samsung Odyssey G3)
hl.monitor({
  output = "desc:Samsung Electric Company LS27AG32x H9JW800006",
  mode = "1920x1080@120",
  position = "auto-left",
  scale = omarchy_monitor_scale,
})

-- GDK scale is GDK_SCALE, the factor GTK draws its own UI at. It's what
-- sizes X11/XWayland windows, which Omarchy leaves unscaled so they stay
-- crisp instead of being stretched by the compositor. GTK only honors whole
-- numbers, so use the nearest integer to the monitor scale, and restart an
-- app for a change to reach it.
local omarchy_gdk_scale = 2
hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
