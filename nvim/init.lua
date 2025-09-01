-- Cool options 
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.splitbelow = true 
vim.opt.splitright = true 
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.ignorecase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir" 
vim.opt.showmode = false
vim.opt.scrolloff = 5

-- Set <space> as map leader (aka hotkey) + some shortcuts
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o' , ':Lazy reload<CR> :source<CR>')
vim.keymap.set('n', '<leader>w' , ':write<CR>')
vim.keymap.set('n', '<leader>q' , ':quit<CR>')
vim.keymap.set('n', '<leader>t' , ':Tutor<CR>')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.keymap.set('n', '<leader>l' , ':Lazy<CR>')

-- Local leader for lazy
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, 
      config = function()
          require("catppuccin").setup({
            auto_integrations = true,
          })
      end,
    },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      module = "telescope",
      config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')

        vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
        vim.keymap.set("n", "<leader>fr", builtin.live_grep, {})
        vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
        vim.keymap.set("n", "<leader>ff", ":Telescope find_files hidden=true <CR>")

      end
    },
    {
      'nvim-treesitter/nvim-treesitter',
      lazy = false,
      branch = 'master',
      build = ':TSUpdate',
      config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "vimdoc", "lua", "bash", "diff", "fish", "gitignore", "hyprlang", "json", "markdown", "python", "nix", "scala", "tmux", "typst", "vim", "rust" },
            sync_install = false,
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },  
        })
      end,
    },
    { 'echasnovski/mini.icons', version = false,
      config = function()
          require("mini.icons").setup()
      end,
    },
    { 'echasnovski/mini.files', version = false,
      config = function()
          require("mini.files").setup({
                vim.keymap.set('n', '<leader>e' , ':lua MiniFiles.open()<CR>')
            })
      end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter", -- Only load when you enter Insert mode
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy", -- Special lazy.nvim event for things that can load later and are not important for the initial UI
        config = function()
            require("Comment").setup()
        end,
    },
    {
        "tpope/vim-sleuth",
        event = { "BufReadPost", "BufNewFile" }, -- Load after your file content
    },  
    {
        "https://github.com/farmergreg/vim-lastplace",
        event = "BufReadPost",
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        config = function()
            require("flash").setup({
                modes = {
                    search = {
                        enabled = true,
                    },
                    char = {
                        enabled = false,
                    },
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "VeryLazy" },
        config = function()
            require("ibl").setup()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup()
        end,
    },
    
    },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "catppuccin-latte" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd("colorscheme catppuccin-latte")

-- Removes status line highlighting
--vim.cmd(":hi statusline guibg=NONE")


