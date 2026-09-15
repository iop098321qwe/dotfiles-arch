-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Replace default terminal/tmux bindings.
hl.unbind("SUPER + RETURN")       -- was Terminal
hl.unbind("SUPER + ALT + RETURN") -- was Tmux
o.bind("SUPER + RETURN", "Tmux", "omarchy-launch-terminal tmux new-session -A")
o.bind("SUPER + ALT + RETURN", "Terminal", { omarchy = "terminal" })

-- Vim-style focus navigation.
hl.unbind("SUPER + J") -- was Toggle window split
hl.unbind("SUPER + K") -- was Keybindings
hl.unbind("SUPER + L") -- was Toggle workspace layout
o.bind("SUPER + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))

-- Vim-style window swapping.
o.bind("SUPER + ALT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + ALT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + ALT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + ALT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

o.bind("SUPER + U", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + I", "Show keybindings", "omarchy menu keybindings")
-- Use the physical apostrophe key so this survives layout changes.
o.bind("SUPER + Apostrophe", "Toggle workspace layout", "omarchy hyprland workspace layout toggle")

o.bind("SUPER + SHIFT + H", "GitHub", {
  webapp = "https://github.com/iop098321qwe?tab=repositories",
  focus = true,
})

hl.unbind("SUPER + SHIFT + SLASH") -- was Passwords (1Password)
o.bind("SUPER + SHIFT + SLASH", "Passwords", {
  launch = "proton-pass",
  focus = "proton-pass",
})

o.bind("SUPER + SHIFT + V", "Proton VPN", {
  launch = "protonvpn-app",
  focus = "protonvpn-app",
})

hl.unbind("SUPER + SHIFT + ALT + E") -- was New email
o.bind("SUPER + SHIFT + ALT + E", "Proton Mail", {
  webapp = "https://mail.proton.me",
})

hl.unbind("SUPER + SHIFT + E") -- was Email
o.bind("SUPER + SHIFT + E", "Email", {
  launch = "betterbird",
  focus = "betterbird",
})

hl.unbind("SUPER + SHIFT + C") -- was Calendar
o.bind("SUPER + SHIFT + C", "Notion Calendar", {
  webapp = "https://calendar.notion.so",
  focus = true,
})

o.bind("SUPER + SHIFT + J", "Notion", {
  webapp = "https://notion.so",
  focus = true,
})
o.bind("SUPER + SHIFT + R", "Reddit", {
  webapp = "https://reddit.com",
  focus = true,
})

hl.unbind("SUPER + SHIFT + W") -- was Omawrite
o.bind("SUPER + SHIFT + W", "Deeptree RocketChat", {
  webapp = "https://msg.deeptree.tech/home",
  focus = true,
})
o.bind("SUPER + SHIFT + Q", "Deeptree Matrix", {
  webapp = "https://muninn.deeptree.tech/index.html",
  focus = true,
})

hl.unbind("SUPER + SHIFT + S") -- was Google Maps
o.bind("SUPER + SHIFT + S", "Vesktop", {
  launch = "vesktop",
  focus = "vesktop",
})

o.bind("SUPER + SHIFT + L", "Emby", {
  webapp = "https://app.emby.media",
  focus = true,
})
o.bind("SUPER + SHIFT + K", "Deeptree Nextcloud", {
  webapp = "https://cloud.deeptree.tech",
  focus = true,
})
o.bind("SUPER + SHIFT + ALT + L", "Amazon", {
  webapp = "https://amazon.com",
  focus = true,
})
o.bind("SUPER + SHIFT + CTRL + M", "Suno", {
  webapp = "https://suno.com",
  focus = true,
})

hl.unbind("SUPER + SHIFT + ALT + A") -- was Grok
o.bind("SUPER + SHIFT + ALT + A", "Anthropic", {
  webapp = "https://claude.ai/new",
  focus = true,
})

o.bind("SUPER + SHIFT + ALT + S", "BambuStudio", {
  launch = "bambustudio",
  focus = "bambustudio",
})

hl.unbind("SUPER + SHIFT + ALT + G") -- was WhatsApp
o.bind("SUPER + SHIFT + ALT + G", "MakerWorld", {
  webapp = "https://makerworld.com/en",
  focus = true,
})

o.bind("SUPER + SHIFT + ALT + Q", "Snapchat", {
  webapp = "https://www.snapchat.com/web",
  focus = true,
})
o.bind("SUPER + SHIFT + CTRL + B", "Firefox", { launch = "firefox" })

o.bind("SUPER + D", "Scratchpad 2", hl.dsp.workspace.toggle_special("scratchpad2"))
o.bind("SUPER + ALT + D", "Move window to scratchpad 2",
  hl.dsp.window.move({ workspace = "special:scratchpad2", follow = false }))
o.bind("SUPER + A", "Scratchpad 3", hl.dsp.workspace.toggle_special("scratchpad3"))
o.bind("SUPER + ALT + A", "Move window to scratchpad 3",
  hl.dsp.window.move({ workspace = "special:scratchpad3", follow = false }))
o.bind("SUPER + Z", "Scratchpad 4", hl.dsp.workspace.toggle_special("scratchpad4"))
o.bind("SUPER + ALT + Z", "Move window to scratchpad 4",
  hl.dsp.window.move({ workspace = "special:scratchpad4", follow = false }))
o.bind("SUPER + E", "Scratchpad 5", hl.dsp.workspace.toggle_special("scratchpad5"))
o.bind("SUPER + ALT + E", "Move window to scratchpad 5",
  hl.dsp.window.move({ workspace = "special:scratchpad5", follow = false }))
o.bind("SUPER + Q", "Scratchpad 6", hl.dsp.workspace.toggle_special("scratchpad6"))
o.bind("SUPER + ALT + Q", "Move window to scratchpad 6",
  hl.dsp.window.move({ workspace = "special:scratchpad6", follow = false }))
o.bind("SUPER + R", "Scratchpad Passwords", hl.dsp.workspace.toggle_special("passwords"))
o.bind("SUPER + ALT + R", "Move window to password scratchpad",
  hl.dsp.window.move({ workspace = "special:passwords", follow = false }))
o.bind("SUPER + M", "Music Scratchpad", hl.dsp.workspace.toggle_special("music"))
o.bind("SUPER + ALT + M", "Move window to music scratchpad",
  hl.dsp.window.move({ workspace = "special:music", follow = false }))
o.bind("SUPER + PERIOD", "Secret Scratchpad", hl.dsp.workspace.toggle_special("secret"))
o.bind("SUPER + ALT + PERIOD", "Move window to secret scratchpad",
  hl.dsp.window.move({ workspace = "special:secret", follow = false }))

o.bind("SUPER + SHIFT + ALT + D", "SSH", { tui = "lazyssh", focus = true })
o.bind("CTRL + ALT + R", "Reload Espanso",
  "sh -c 'espanso restart && omarchy-notification-send \"Espanso reloaded successfully.\"'")
