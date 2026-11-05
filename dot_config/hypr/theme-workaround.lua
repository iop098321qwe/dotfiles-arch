-- Temporary workaround for https://github.com/omacom/omarchy/issues/16365.
-- The directory contains only the Brave Origin policy-refresh guard.
-- TODO: (AI, omarchy#16365) Remove this PATH helper and its require in
-- hyprland.lua only when the packaged fix is installed on THIS computer and
-- tested without the Brave Origin guard. Follow the checklist in
-- ~/.config/omarchy/workarounds/bin/brave-origin; retire the guard and helper
-- together in live config AND Chezmoi source. Remove the workaround directory
-- from the session PATH, restart the shell, and verify theme hooks still run.
-- Do not remove on an upstream merge/issue closure or version number alone.
-- Once complete, delete this entire TODO comment block as well.
local overrides = os.getenv("HOME") .. "/.config/omarchy/workarounds/bin"
local path = os.getenv("PATH") or "/usr/bin"
if not (":" .. path .. ":"):find(":" .. overrides .. ":", 1, true) then
  path = overrides .. ":" .. path
end
hl.env("PATH", path)
