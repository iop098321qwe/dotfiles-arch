-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Replace default terminal/tmux bindings.
o.rebind("SUPER + RETURN", "Tmux", "omarchy-launch-terminal tmux new-session -A")
o.rebind("SUPER + ALT + RETURN", "Terminal", { omarchy = "terminal" })

-- Vim-style focus navigation.
o.rebind("SUPER + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
o.rebind("SUPER + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))
o.rebind("SUPER + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))
o.rebind("SUPER + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))

-- Vim-style window swapping.
o.rebind("SUPER + ALT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.rebind("SUPER + ALT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.rebind("SUPER + ALT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.rebind("SUPER + ALT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

o.rebind("SUPER + U", "Toggle window split", hl.dsp.layout("togglesplit"))
o.rebind("SUPER + CTRL + K", "Show keybindings", "omarchy menu keybindings")
o.rebind("SUPER + CTRL + ALT + K", "Tmux keybindings", "omarchy-menu-tmux-keybindings")
o.rebind("SUPER + CTRL + SHIFT + K", "Herdr keybindings", "omarchy-menu-herdr-keybindings")
-- Use the physical apostrophe key so this survives layout changes.
o.rebind("SUPER + Apostrophe", "Toggle workspace layout", "omarchy hyprland workspace layout toggle")
o.rebind("SUPER + ALT + Apostrophe", "Cycle workspace layout back",
  "omarchy hyprland workspace layout toggle back")

o.rebind("SUPER + SHIFT + SLASH", "Passwords", {
  launch = "proton-pass",
  focus = "proton-pass",
})

o.rebind("SUPER + SHIFT + V", "Proton VPN", {
  launch = "protonvpn-app",
  focus = "protonvpn-app",
})

o.rebind("SUPER + SHIFT + ALT + E", "Proton Mail", {
  webapp = "https://mail.proton.me",
})

o.rebind("SUPER + SHIFT + E", "Email", {
  launch = "betterbird",
  focus = "betterbird",
})

o.rebind("SUPER + SHIFT + C", "Notion Calendar", {
  webapp = "https://calendar.notion.so",
  focus = true,
})

o.rebind("SUPER + SHIFT + J", "Notion", {
  webapp = "https://notion.so",
  focus = true,
})

o.rebind("SUPER + SHIFT + W", "Deeptree Matrix", {
  webapp = "https://muninn.deeptree.tech/index.html",
  focus = true,
})

o.rebind("SUPER + SHIFT + K", "Deeptree Nextcloud", {
  webapp = "https://cloud.deeptree.tech",
  focus = true,
})

o.rebind("SUPER + SHIFT + ALT + A", "Anthropic", {
  webapp = "https://claude.ai/new",
  focus = true,
})

o.rebind("SUPER + SHIFT + ALT + Q", "Snapchat", {
  webapp = "https://www.snapchat.com/web",
  focus = true,
})
o.rebind("SUPER + SHIFT + CTRL + B", "Firefox", { launch = "firefox" })

o.rebind("SUPER + D", "Scratchpad 2", hl.dsp.workspace.toggle_special("scratchpad2"))
o.rebind("SUPER + ALT + D", "Move window to scratchpad 2",
  hl.dsp.window.move({ workspace = "special:scratchpad2", follow = false }))
o.rebind("SUPER + Z", "Scratchpad 4", hl.dsp.workspace.toggle_special("scratchpad4"))
o.rebind("SUPER + ALT + Z", "Move window to scratchpad 4",
  hl.dsp.window.move({ workspace = "special:scratchpad4", follow = false }))
o.rebind("SUPER + E", "Scratchpad 5", hl.dsp.workspace.toggle_special("scratchpad5"))
o.rebind("SUPER + ALT + E", "Move window to scratchpad 5",
  hl.dsp.window.move({ workspace = "special:scratchpad5", follow = false }))
o.rebind("SUPER + Q", "Scratchpad 6", hl.dsp.workspace.toggle_special("scratchpad6"))
o.rebind("SUPER + ALT + Q", "Move window to scratchpad 6",
  hl.dsp.window.move({ workspace = "special:scratchpad6", follow = false }))
o.rebind("SUPER + R", "Scratchpad Passwords", hl.dsp.workspace.toggle_special("passwords"))
o.rebind("SUPER + ALT + R", "Move window to password scratchpad",
  hl.dsp.window.move({ workspace = "special:passwords", follow = false }))
o.rebind("SUPER + PERIOD", "Secret Scratchpad", hl.dsp.workspace.toggle_special("secret"))
o.rebind("SUPER + ALT + PERIOD", "Move window to secret scratchpad",
  hl.dsp.window.move({ workspace = "special:secret", follow = false }))

o.rebind("SUPER + SHIFT + ALT + D", "SSH", { tui = "lazyssh", focus = true })
o.rebind("CTRL + ALT + R", "Reload Espanso",
  "sh -c 'espanso restart && omarchy-notification-send \"Espanso reloaded successfully.\"'")
