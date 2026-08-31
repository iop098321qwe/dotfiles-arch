-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1.25
local omarchy_laptop_monitor_scale = 1

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
-- hl.monitor({ output = "DP-2", mode = "2560x1440@144", position = "0x0", scale = 1 })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })

-- External Display (Samsung Odyssey G7)
hl.monitor({
  output = "desc:Samsung Electric Company LC27G7xT H4ZR703280",
  mode = "preferred",
  position = "auto",
  scale = omarchy_monitor_scale,
})

-- Laptop Display
hl.monitor({
  output = "desc:InfoVision Optoelectronics (Kunshan) Co.Ltd China 0x3D41 0x00000004",
  mode = "preferred",
  position = "auto-left",
  scale = omarchy_laptop_monitor_scale,
})
