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

vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
vim.keymap.set("n", "<leader>bb", ":bnext<CR>")
vim.keymap.set("n", "<leader>mm", ":Mason<CR>")

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

vim.keymap.set("n", "<leader>L", ":Lazy<CR>")

-- Local leader for lazy
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{
			"catppuccin/nvim",
			name = "catppuccin",
			priority = 1000,
			config = function()
				require("catppuccin").setup({
					auto_integrations = true,
				})
			end,
		},
		-- replace telescope with snacks i think, will prove worthwhile
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{
			"nvim-telescope/telescope.nvim",
			tag = "0.1.8",
			dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
			module = "telescope",
			config = function()
				require("telescope").setup({
					extensions = {
						fzf = {
							fuzzy = true, -- false will only do exact matching
							override_generic_sorter = true, -- override the generic sorter
							override_file_sorter = true, -- override the file sorter
							case_mode = "smart_case", -- or "ignore_case" or "respect_case"
							-- the default case_mode is "smart_case"
						},
					},
				})
				require("telescope").load_extension("fzf")
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
				vim.keymap.set("n", "<leader>fr", builtin.live_grep, { desc = "Telescope live grep" })
				vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
				vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
				vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope git files" })
				vim.keymap.set(
					"n",
					"<leader>ff",
					":Telescope find_files hidden=true <CR>",
					{ desc = "Telescope find files" }
				)
			end,
		},
		{
			"nvim-treesitter/nvim-treesitter",
			lazy = false,
			branch = "master",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup({
					ensure_installed = {
						"c",
						"lua",
						"bash",
						"diff",
						"fish",
						"gitignore",
						"hyprlang",
						"json",
						"markdown",
						"python",
						"nix",
						"scala",
						"latex",
						"tmux",
						"rust",
					},
					sync_install = false,
					auto_install = true,
					highlight = { enable = true },
					indent = { enable = true },
				})
			end,
		},
		{
			"echasnovski/mini.icons",
			version = false,
			config = function()
				require("mini.icons").setup()
			end,
		},
		{
			"echasnovski/mini.files",
			version = false,
			config = function()
				require("mini.files").setup({
					vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>"),
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
			-- leader gc for line and leader gb for block comment, de prfrce en visual mode
			config = function()
				require("Comment").setup()
			end,
		},
		{
			"tpope/vim-sleuth",
			event = { "BufReadPost", "BufNewFile" }, -- Load after your file content
		},
		{
			"farmergreg/vim-lastplace",
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
							enabled = true,
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
			lazy = true,
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("lualine").setup()
			end,
		},
		{
			"kdheepak/lazygit.nvim",
			lazy = true,
			cmd = {
				"LazyGit",
				"LazyGitConfig",
				"LazyGitCurrentFile",
				"LazyGitFilter",
				"LazyGitFilterCurrentFile",
			},
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			keys = {
				{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			},
		},
		{
			"lewis6991/gitsigns.nvim",
			signs = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged = {
				add = { text = "┃" },
				change = { text = "┃" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
			numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
			linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
			word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
			watch_gitdir = {
				follow_files = true,
			},
			auto_attach = true,
			attach_to_untracked = false,
			current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 1000,
				ignore_whitespace = false,
				virt_text_priority = 100,
				use_focus = true,
			},
			current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
			sign_priority = 6,
			update_debounce = 100,
			status_formatter = nil, -- Use default
			max_file_length = 40000, -- Disable if file is longer than this (in lines)
			preview_config = {
				-- Options passed to nvim_open_win
				style = "minimal",
				relative = "cursor",
				row = 0,
				col = 1,
			},
		},
		{
			"stevearc/conform.nvim",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				local conform = require("conform")

				conform.setup({
					formatters_by_ft = {
						json = { "prettier" },
						yaml = { "prettier" },
						markdown = { "prettier" },
						lua = { "stylua" },
						python = { "isort", "black" },
						latex = { "tex-fmt" },
					},
					format_on_save = {
						lsp_fallback = true,
						async = false,
						timeout_ms = 500,
					},
				})

				vim.keymap.set({ "n", "v" }, "<leader>mp", function()
					conform.format({
						lsp_fallback = true,
						async = false,
						timeout_ms = 500,
					})
				end, { desc = "Format file or range (in visual mode)" })
			end,
		},
		{
			"mfussenegger/nvim-lint",
			event = {
				"BufReadPre",
				"BufNewFile",
			},
			config = function()
				local lint = require("lint")

				lint.linters_by_ft = {
					python = { "pylint" },
				}

				local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

				vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
					group = lint_augroup,
					callback = function()
						lint.try_lint()
					end,
				})

				vim.keymap.set("n", "<leader>l", function()
					lint.try_lint()
				end, { desc = "Trigger linting for current file" })
			end,
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				preset = "helix",
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{
			"williamboman/mason.nvim",
			dependencies = {
				"WhoIsSethDaniel/mason-tool-installer.nvim",
			},
			config = function()
				local mason = require("mason")

				local mason_tool_installer = require("mason-tool-installer")

				-- enable mason and configure icons
				mason.setup({
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				})

				mason_tool_installer.setup({
					ensure_installed = {
						"prettier", -- prettier formatter
						"stylua", -- lua formatter
						"isort", -- python formatter
						"black", -- python formatter
						"pylint", -- python linter
					},
				})
			end,
		},
		{
			"saghen/blink.cmp",
			opts_extend = {
				"sources.completion.enabled_providers",
				"sources.compat",
				"sources.default",
			},
			dependencies = {
				"rafamadriz/friendly-snippets",
				-- add blink.compat to dependencies
				{
					"saghen/blink.compat",
					optional = true, -- make optional so it's only enabled if any extras need it
					opts = {},
				},
			},
			event = "InsertEnter", -- optional: provides snippets for the snippet source
			dependencies = { "rafamadriz/friendly-snippets" },

			-- use a release tag to download pre-built binaries
			version = "1.*",

			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				-- All presets have the following mappings:
				-- TODO : add to which-key.nvim
				-- C-space: Open menu or open docs if already open
				-- C-n/C-p or Up/Down: Select next/previous item
				-- C-e: Hide menu
				-- C-k: Toggle signature help (if signature.enabled = true)

				keymap = { preset = "super-tab" },

				-- (Default) Only show the documentation popup when manually triggered
				-- how to manually trigger ?
				completion = { documentation = { auto_show = true } },

				-- Default list of enabled providers defined so that you can extend it
				-- elsewhere in your config, without redefining it, due to `opts_extend`
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},

				fuzzy = { implementation = "prefer_rust_with_warning" },
			},
			opts_extend = { "sources.default" },
		},
		-- end of plugin thingy
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

-- need to figure out the lsp stuff thingy so i can start using neovim as my main code editor

-- LSP native config
-- vim.lsp.config("luals", {
-- 	cmd = { "lua-language-server" },
-- 	filetypes = { "lua" },
-- 	root_markers = { ".luarc.json", ".luarc.jsonc" },
-- })
--
-- texlab as well
--
-- vim.lsp.enable("luals")
