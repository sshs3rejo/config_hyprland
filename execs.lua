-- User configuration overrides
-- Loaded after ~/.config/hypr/hyprland/execs.lua

hl.on("hyprland.start", function()
    hl.exec_cmd("xhost +local:root")
end)
