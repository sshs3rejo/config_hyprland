-- User configuration overrides
-- Loaded after ~/.config/hypr/hyprland/general.lua

hl.config({
    input = {
        -- kb_layout is managed by end4-pC (Settings -> Hyprland -> Input -> Keyboard).
        -- The shell writes it to ~/.config/hypr/hyprland/shellOverrides/main.lua,
        -- which loads after this file and therefore takes precedence.
        -- Only keep here what the shell does not cover:
        kb_variant = "thinkpad",
        kb_model   = "abnt2",

        touchpad = {
            natural_scroll = false,
        }
    }
})
