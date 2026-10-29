-- Personal keybindings. Unbind defaults before replacing them on Omarchy 4.0.
--
-- ONE-TIME AGENT INSTRUCTIONS: Review every TODO(omarchy-4.5) in this file
-- and hypr/input.lua after upgrading. Verify installed feature support first;
-- never activate upgrade-only code on 4.0. Back up every file before editing.
-- Complete each TODO, preserving actions, URLs, focus behavior, and options.
-- Explicitly tell the user every shortcut/action changed and which bindings
-- were mechanically converted. Reload with hyprctl reload, then check
-- hyprctl configerrors and registered bindings; validate input changes too.
-- Remove each completed TODO. Keep unresolved TODOs and these instructions;
-- remove this instruction block itself only when every TODO is complete.
--
-- TODO(omarchy-4.5): Once native o.rebind exists, convert EVERY active personal
-- o.bind below to o.rebind and remove its redundant paired hl.unbind calls.
-- Preserve any intentional disable-only unbinds. Do not add a compatibility
-- helper or call o.rebind before the upgrade. This protects custom bindings
-- against future defaults until the user deliberately changes those mappings.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- TODO(omarchy-4.5): Verify inherited defaults: SUPER+A selects all, SUPER+M
-- minimizes to the dock, SUPER+SHIFT+Q opens Calculator, and SUPER+I / SHIFT+I
-- cycle input forward/backward. Leave these chords WITHOUT personal bindings
-- or unbinds. Scratchpad 3/music toggle AND move-to bindings are retired.
-- Right Alt dictation versus German AltGr is an ACCEPTED overlap: leave it
-- alone unless the user requests a future change; it is not a migration blocker.

-- Replace default terminal/tmux bindings.
hl.unbind("SUPER + RETURN")       -- was Terminal
hl.unbind("SUPER + ALT + RETURN") -- was Tmux
o.bind("SUPER + RETURN", "Tmux", "omarchy-launch-terminal tmux new-session -A")
o.bind("SUPER + ALT + RETURN", "Terminal", { omarchy = "terminal" })

-- Vim-style focus navigation.
hl.unbind("SUPER + J") -- was Toggle window split
hl.unbind("SUPER + K") -- was Keybindings
hl.unbind("SUPER + L") -- was Toggle workspace layout
hl.unbind("SUPER + H")
o.bind("SUPER + H", "Move window focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Move window focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Move window focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Move window focus right", hl.dsp.focus({ direction = "r" }))

-- Vim-style window swapping.
hl.unbind("SUPER + ALT + K") -- was Tmux keybindings
hl.unbind("SUPER + ALT + L") -- 4.5: backward layout cycle; preserve swap right
hl.unbind("SUPER + ALT + H")
hl.unbind("SUPER + ALT + J")
o.bind("SUPER + ALT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + ALT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + ALT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + ALT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

hl.unbind("SUPER + U")
o.bind("SUPER + U", "Toggle window split", hl.dsp.layout("togglesplit"))
hl.unbind("SUPER + CTRL + K") -- was Herdr keybindings, moved below
o.bind("SUPER + CTRL + K", "Show keybindings", "omarchy menu keybindings")
hl.unbind("SUPER + CTRL + ALT + K")
o.bind("SUPER + CTRL + ALT + K", "Tmux keybindings", "omarchy-menu-tmux-keybindings")
hl.unbind("SUPER + CTRL + SHIFT + K")
o.bind("SUPER + CTRL + SHIFT + K", "Herdr keybindings", "omarchy-menu-herdr-keybindings")
-- Use the physical apostrophe key so this survives layout changes.
hl.unbind("SUPER + Apostrophe")
o.bind("SUPER + Apostrophe", "Toggle workspace layout", "omarchy hyprland workspace layout toggle")
-- TODO(omarchy-4.5): Verify the installed layout command supports `back`, then
-- activate the binding below with native o.rebind. Test forward and backward
-- cycling between dwindle, scrolling, and floating. Keep SUPER+ALT+L for swapping.
-- o.rebind("SUPER + ALT + Apostrophe", "Cycle workspace layout back",
--   "omarchy hyprland workspace layout toggle back")

hl.unbind("SUPER + SHIFT + H")
o.bind("SUPER + SHIFT + H", "GitHub", {
  webapp = "https://github.com/iop098321qwe?tab=repositories",
  focus = true,
})

hl.unbind("SUPER + SHIFT + SLASH") -- was Passwords (1Password)
o.bind("SUPER + SHIFT + SLASH", "Passwords", {
  launch = "proton-pass",
  focus = "proton-pass",
})

hl.unbind("SUPER + SHIFT + V")
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

hl.unbind("SUPER + SHIFT + J")
o.bind("SUPER + SHIFT + J", "Notion", {
  webapp = "https://notion.so",
  focus = true,
})
hl.unbind("SUPER + SHIFT + R")
o.bind("SUPER + SHIFT + R", "Reddit", {
  webapp = "https://reddit.com",
  focus = true,
})

hl.unbind("SUPER + SHIFT + W") -- was Omawrite
o.bind("SUPER + SHIFT + W", "Deeptree Matrix", {
  webapp = "https://muninn.deeptree.tech/index.html",
  focus = true,
})

hl.unbind("SUPER + SHIFT + S") -- was Google Maps
o.bind("SUPER + SHIFT + S", "Vesktop", {
  launch = "vesktop",
  focus = "vesktop",
})

hl.unbind("SUPER + SHIFT + L")
o.bind("SUPER + SHIFT + L", "Emby", {
  webapp = "https://app.emby.media",
  focus = true,
})
hl.unbind("SUPER + SHIFT + K")
o.bind("SUPER + SHIFT + K", "Deeptree Nextcloud", {
  webapp = "https://cloud.deeptree.tech",
  focus = true,
})
hl.unbind("SUPER + SHIFT + ALT + L")
o.bind("SUPER + SHIFT + ALT + L", "Amazon", {
  webapp = "https://amazon.com",
  focus = true,
})
hl.unbind("SUPER + SHIFT + CTRL + M")
o.bind("SUPER + SHIFT + CTRL + M", "Suno", {
  webapp = "https://suno.com",
  focus = true,
})

hl.unbind("SUPER + SHIFT + ALT + A") -- was Grok
o.bind("SUPER + SHIFT + ALT + A", "Anthropic", {
  webapp = "https://claude.ai/new",
  focus = true,
})

hl.unbind("SUPER + SHIFT + ALT + S")
o.bind("SUPER + SHIFT + ALT + S", "BambuStudio", {
  launch = "bambustudio",
  focus = "bambustudio",
})

hl.unbind("SUPER + SHIFT + ALT + G") -- was WhatsApp
o.bind("SUPER + SHIFT + ALT + G", "MakerWorld", {
  webapp = "https://makerworld.com/en",
  focus = true,
})

hl.unbind("SUPER + SHIFT + ALT + Q")
o.bind("SUPER + SHIFT + ALT + Q", "Snapchat", {
  webapp = "https://www.snapchat.com/web",
  focus = true,
})
hl.unbind("SUPER + SHIFT + CTRL + B")
o.bind("SUPER + SHIFT + CTRL + B", "Firefox", { launch = "firefox" })

hl.unbind("SUPER + D")
hl.unbind("SUPER + ALT + D")
o.bind("SUPER + D", "Scratchpad 2", hl.dsp.workspace.toggle_special("scratchpad2"))
o.bind("SUPER + ALT + D", "Move window to scratchpad 2",
  hl.dsp.window.move({ workspace = "special:scratchpad2", follow = false }))
hl.unbind("SUPER + Z")
hl.unbind("SUPER + ALT + Z")
o.bind("SUPER + Z", "Scratchpad 4", hl.dsp.workspace.toggle_special("scratchpad4"))
o.bind("SUPER + ALT + Z", "Move window to scratchpad 4",
  hl.dsp.window.move({ workspace = "special:scratchpad4", follow = false }))
hl.unbind("SUPER + E")
hl.unbind("SUPER + ALT + E")
o.bind("SUPER + E", "Scratchpad 5", hl.dsp.workspace.toggle_special("scratchpad5"))
o.bind("SUPER + ALT + E", "Move window to scratchpad 5",
  hl.dsp.window.move({ workspace = "special:scratchpad5", follow = false }))
hl.unbind("SUPER + Q") -- 4.5: Close window; preserve scratchpad 6 instead
o.bind("SUPER + Q", "Scratchpad 6", hl.dsp.workspace.toggle_special("scratchpad6"))
hl.unbind("SUPER + ALT + Q")
o.bind("SUPER + ALT + Q", "Move window to scratchpad 6",
  hl.dsp.window.move({ workspace = "special:scratchpad6", follow = false }))
hl.unbind("SUPER + R")
hl.unbind("SUPER + ALT + R")
o.bind("SUPER + R", "Scratchpad Passwords", hl.dsp.workspace.toggle_special("passwords"))
o.bind("SUPER + ALT + R", "Move window to password scratchpad",
  hl.dsp.window.move({ workspace = "special:passwords", follow = false }))
hl.unbind("SUPER + PERIOD")
hl.unbind("SUPER + ALT + PERIOD")
o.bind("SUPER + PERIOD", "Secret Scratchpad", hl.dsp.workspace.toggle_special("secret"))
o.bind("SUPER + ALT + PERIOD", "Move window to secret scratchpad",
  hl.dsp.window.move({ workspace = "special:secret", follow = false }))

hl.unbind("SUPER + SHIFT + ALT + D")
o.bind("SUPER + SHIFT + ALT + D", "SSH", { tui = "lazyssh", focus = true })
hl.unbind("CTRL + ALT + R")
o.bind("CTRL + ALT + R", "Reload Espanso",
  "sh -c 'espanso restart && omarchy-notification-send \"Espanso reloaded successfully.\"'")
