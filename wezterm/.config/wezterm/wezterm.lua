-- vim: tabstop=2 shiftwidth=2 expandtab

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local gui = wezterm.gui
local appearance = 'Dark'
if gui then
  appearance = wezterm.gui.get_appearance()
end
  
function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Tokyo Night'
  else
    return 'Tokyo Night Day'
  end
end
  

config.color_scheme = scheme_for_appearance(appearance)

config.enable_tab_bar = false
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 16
config.scrollback_lines = 100000

-- and finally, return the configuration to wezterm
return config