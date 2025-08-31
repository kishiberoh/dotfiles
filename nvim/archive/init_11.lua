vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true

vim.g.mapleader = " "
vim.g.have_nerd_font = true


-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- Setup plugins with lazy.nvim
require("lazy").setup({
 'NMAC427/guess-indent.nvim', 
  {
    "catppuccin/nvim",  -- Catppuccin theme
    name = "catppuccin",
    priority = 1000,    -- load this plugin first
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",  -- latte, frappe, macchiato, mocha
        -- you can add more config here if you want
      })
      vim.cmd.colorscheme("catppuccin-frappe")
    end,
  },
})

vim.keymap.set('n', '<leader>o' , ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w' , ':write<CR>')
vim.keymap.set('n', '<leader>q' , ':quit<CR>')
vim.keymap.set('n', '<leader>e' , ':Ex<CR>')
vim.keymap.set('n', '<leader>l' , ':Lazy<CR>')

vim.cmd(":hi statusline guibg=NONE")
