local wezterm = require 'wezterm'


return {
  -- Font settings
  font = wezterm.font("0xProto Nerd Font", { weight = "Bold" }),
  font_size = 12,

  -- Disable line padding to prevent overflow/spacing issues
  line_height = 1.0,                                  -- Prevents extra spacing between lines
  cell_width = 1.0,                                   -- Prevents horizontal overflow
  adjust_window_size_when_changing_font_size = false, -- Avoid resizing quirks

  -- Catppuccin theme
  color_scheme = "Catppuccin Latte",
  enable_wayland = false,
  -- Window/padding adjustments
  window_padding = {
    left = 5,
    right = 5,
    top = 0,    -- Removes space above the prompt
    bottom = 0, -- Removes space below the prompt
  },

  default_prog = { '/usr/bin/fish', '-l' },
  -- Disable scrollbar if it causes overflow
  enable_scroll_bar = false,

  enable_tab_bar = false,

  -- Optional: Ensure the prompt starts at the top
  default_cursor_style = "BlinkingBlock",
  initial_rows = 24, -- Adjust based on your screen
  initial_cols = 80,
}
