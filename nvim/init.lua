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

-- complement to vimtutor : http://vimgenius.com/lessons

-- Set <space> as map leader (aka hotkey) + some shortcuts
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>ww", ":write<CR>", { desc = "Write" })
vim.keymap.set("n", "<leader>wq", ":write<CR> :quit<CR>", { desc = "Write and quit" })
vim.keymap.set("n", "<leader>qq", ":quit<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>qa", ":qall<CR>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>bb", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>mm", ":Mason<CR>", { desc = "Write" })

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

vim.keymap.set("n", "<leader>L", ":Lazy<CR>", { desc = "Lazy" })

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
		{
			"rebelot/kanagawa.nvim",
			lazy = false,
			priority = 1000,
			opts = {},
		},
		{
			"wnkz/monoglow.nvim",
			lazy = false,
			priority = 1000,
			opts = {},
		},
		-- lua/plugins/rose-pine.lua
		{
			"rose-pine/neovim",
			name = "rose-pine",
			lazy = false,
			priority = 1000,
			opts = {},
		},
		-- -- replace telescope with snacks i think, will prove worthwhile
		-- { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		-- {
		-- 	"nvim-telescope/telescope.nvim",
		-- 	tag = "0.1.8",
		-- 	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		-- 	module = "telescope",
		-- 	config = function()
		-- 		require("telescope").setup({
		-- 			extensions = {
		-- 				fzf = {
		-- 					fuzzy = true, -- false will only do exact matching
		-- 					override_generic_sorter = true, -- override the generic sorter
		-- 					override_file_sorter = true, -- override the file sorter
		-- 					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		-- 					-- the default case_mode is "smart_case"
		-- 				},
		-- 			},
		-- 		})
		-- 		require("telescope").load_extension("fzf")
		-- 		local builtin = require("telescope.builtin")
		-- 		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		-- 		vim.keymap.set("n", "<leader>fr", builtin.live_grep, { desc = "Telescope live grep" })
		-- 		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		-- 		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
		-- 		vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = "Telescope git files" })
		-- 		vim.keymap.set(
		-- 			"n",
		-- 			"<leader>ff",
		-- 			":Telescope find_files hidden=true <CR>",
		-- 			{ desc = "Telescope find files" }
		-- 		)
		-- 	end,
		-- },
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
		-- {
		-- 	"lewis6991/gitsigns.nvim",
		-- 	signs = {
		-- 		add = { text = "┃" },
		-- 		change = { text = "┃" },
		-- 		delete = { text = "_" },
		-- 		topdelete = { text = "‾" },
		-- 		changedelete = { text = "~" },
		-- 		untracked = { text = "┆" },
		-- 	},
		-- 	signs_staged = {
		-- 		add = { text = "┃" },
		-- 		change = { text = "┃" },
		-- 		delete = { text = "_" },
		-- 		topdelete = { text = "‾" },
		-- 		changedelete = { text = "~" },
		-- 		untracked = { text = "┆" },
		-- 	},
		-- 	signs_staged_enable = true,
		-- 	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		-- 	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		-- 	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		-- 	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		-- 	watch_gitdir = {
		-- 		follow_files = true,
		-- 	},
		-- 	auto_attach = true,
		-- 	attach_to_untracked = false,
		-- 	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		-- 	current_line_blame_opts = {
		-- 		virt_text = true,
		-- 		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		-- 		delay = 1000,
		-- 		ignore_whitespace = false,
		-- 		virt_text_priority = 100,
		-- 		use_focus = true,
		-- 	},
		-- 	current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
		-- 	sign_priority = 6,
		-- 	update_debounce = 100,
		-- 	status_formatter = nil, -- Use default
		-- 	max_file_length = 40000, -- Disable if file is longer than this (in lines)
		-- 	preview_config = {
		-- 		-- Options passed to nvim_open_win
		-- 		style = "minimal",
		-- 		relative = "cursor",
		-- 		row = 0,
		-- 		col = 1,
		-- 	},
		-- },
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
			"folke/todo-comments.nvim",
			event = "VimEnter",
			dependencies = { "nvim-lua/plenary.nvim" },
			opts = {},
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

				keymap = { preset = "enter" },

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
		{
			"folke/snacks.nvim",
			priority = 1000,
			lazy = false,
			---@type snacks.Config
			opts = {
				bigfile = { enabled = true },
				dashboard = { enabled = true },
				explorer = { enabled = false },
				indent = { enabled = true },
				input = { enabled = true },
				notifier = {
					enabled = true,
					timeout = 3000,
				},
				picker = { enabled = true },
				quickfile = { enabled = true },
				scope = { enabled = true },
				scroll = { enabled = true },
				statuscolumn = { enabled = true },
				words = { enabled = true },
				styles = {
					notification = {
						-- wo = { wrap = true } -- Wrap notifications
					},
				},
			},
			keys = {
				-- Top Pickers & Explorer
				{
					"<leader><space>",
					function()
						Snacks.picker.smart()
					end,
					desc = "Smart Find Files",
				},
				{
					"<leader>,",
					function()
						Snacks.picker.buffers()
					end,
					desc = "Buffers",
				},
				{
					"<leader>/",
					function()
						Snacks.picker.grep()
					end,
					desc = "Grep",
				},
				{
					"<leader>:",
					function()
						Snacks.picker.command_history()
					end,
					desc = "Command History",
				},
				{
					"<leader>n",
					function()
						Snacks.picker.notifications()
					end,
					desc = "Notification History",
				},
				{
					"<leader>e",
					function()
						Snacks.explorer()
					end,
					desc = "File Explorer",
				},
				-- find
				{
					"<leader>fb",
					function()
						Snacks.picker.buffers()
					end,
					desc = "Buffers",
				},
				{
					"<leader>fc",
					function()
						Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
					end,
					desc = "Find Config File",
				},
				{
					"<leader>ff",
					function()
						Snacks.picker.files()
					end,
					desc = "Find Files",
				},
				{
					"<leader>fg",
					function()
						Snacks.picker.git_files()
					end,
					desc = "Find Git Files",
				},
				{
					"<leader>fp",
					function()
						Snacks.picker.projects()
					end,
					desc = "Projects",
				},
				{
					"<leader>fr",
					function()
						Snacks.picker.recent()
					end,
					desc = "Recent",
				},
				-- git
				{
					"<leader>gb",
					function()
						Snacks.picker.git_branches()
					end,
					desc = "Git Branches",
				},
				{
					"<leader>gl",
					function()
						Snacks.picker.git_log()
					end,
					desc = "Git Log",
				},
				{
					"<leader>gL",
					function()
						Snacks.picker.git_log_line()
					end,
					desc = "Git Log Line",
				},
				{
					"<leader>gs",
					function()
						Snacks.picker.git_status()
					end,
					desc = "Git Status",
				},
				{
					"<leader>gS",
					function()
						Snacks.picker.git_stash()
					end,
					desc = "Git Stash",
				},
				{
					"<leader>gd",
					function()
						Snacks.picker.git_diff()
					end,
					desc = "Git Diff (Hunks)",
				},
				{
					"<leader>gf",
					function()
						Snacks.picker.git_log_file()
					end,
					desc = "Git Log File",
				},
				-- Grep
				{
					"<leader>sb",
					function()
						Snacks.picker.lines()
					end,
					desc = "Buffer Lines",
				},
				{
					"<leader>sB",
					function()
						Snacks.picker.grep_buffers()
					end,
					desc = "Grep Open Buffers",
				},
				{
					"<leader>sg",
					function()
						Snacks.picker.grep()
					end,
					desc = "Grep",
				},
				{
					"<leader>sw",
					function()
						Snacks.picker.grep_word()
					end,
					desc = "Visual selection or word",
					mode = { "n", "x" },
				},
				-- search
				{
					'<leader>s"',
					function()
						Snacks.picker.registers()
					end,
					desc = "Registers",
				},
				{
					"<leader>s/",
					function()
						Snacks.picker.search_history()
					end,
					desc = "Search History",
				},
				{
					"<leader>sa",
					function()
						Snacks.picker.autocmds()
					end,
					desc = "Autocmds",
				},
				{
					"<leader>sb",
					function()
						Snacks.picker.lines()
					end,
					desc = "Buffer Lines",
				},
				{
					"<leader>sc",
					function()
						Snacks.picker.command_history()
					end,
					desc = "Command History",
				},
				{
					"<leader>sC",
					function()
						Snacks.picker.commands()
					end,
					desc = "Commands",
				},
				{
					"<leader>sd",
					function()
						Snacks.picker.diagnostics()
					end,
					desc = "Diagnostics",
				},
				{
					"<leader>sD",
					function()
						Snacks.picker.diagnostics_buffer()
					end,
					desc = "Buffer Diagnostics",
				},
				{
					"<leader>sh",
					function()
						Snacks.picker.help()
					end,
					desc = "Help Pages",
				},
				{
					"<leader>sH",
					function()
						Snacks.picker.highlights()
					end,
					desc = "Highlights",
				},
				{
					"<leader>si",
					function()
						Snacks.picker.icons()
					end,
					desc = "Icons",
				},
				{
					"<leader>sj",
					function()
						Snacks.picker.jumps()
					end,
					desc = "Jumps",
				},
				{
					"<leader>sk",
					function()
						Snacks.picker.keymaps()
					end,
					desc = "Keymaps",
				},
				{
					"<leader>sl",
					function()
						Snacks.picker.loclist()
					end,
					desc = "Location List",
				},
				{
					"<leader>sm",
					function()
						Snacks.picker.marks()
					end,
					desc = "Marks",
				},
				{
					"<leader>sM",
					function()
						Snacks.picker.man()
					end,
					desc = "Man Pages",
				},
				{
					"<leader>sp",
					function()
						Snacks.picker.lazy()
					end,
					desc = "Search for Plugin Spec",
				},
				{
					"<leader>sq",
					function()
						Snacks.picker.qflist()
					end,
					desc = "Quickfix List",
				},
				{
					"<leader>sR",
					function()
						Snacks.picker.resume()
					end,
					desc = "Resume",
				},
				{
					"<leader>su",
					function()
						Snacks.picker.undo()
					end,
					desc = "Undo History",
				},
				{
					"<leader>tt",
					function()
						Snacks.picker.colorschemes()
					end,
					desc = "Colorschemes",
				},
				-- LSP
				{
					"gd",
					function()
						Snacks.picker.lsp_definitions()
					end,
					desc = "Goto Definition",
				},
				{
					"gD",
					function()
						Snacks.picker.lsp_declarations()
					end,
					desc = "Goto Declaration",
				},
				{
					"gr",
					function()
						Snacks.picker.lsp_references()
					end,
					nowait = true,
					desc = "References",
				},
				{
					"gI",
					function()
						Snacks.picker.lsp_implementations()
					end,
					desc = "Goto Implementation",
				},
				{
					"gy",
					function()
						Snacks.picker.lsp_type_definitions()
					end,
					desc = "Goto T[y]pe Definition",
				},
				{
					"<leader>ss",
					function()
						Snacks.picker.lsp_symbols()
					end,
					desc = "LSP Symbols",
				},
				{
					"<leader>sS",
					function()
						Snacks.picker.lsp_workspace_symbols()
					end,
					desc = "LSP Workspace Symbols",
				},
				-- Other
				{
					"<leader>z",
					function()
						Snacks.zen()
					end,
					desc = "Toggle Zen Mode",
				},
				{
					"<leader>Z",
					function()
						Snacks.zen.zoom()
					end,
					desc = "Toggle Zoom",
				},
				{
					"<leader>.",
					function()
						Snacks.scratch()
					end,
					desc = "Toggle Scratch Buffer",
				},
				{
					"<leader>S",
					function()
						Snacks.scratch.select()
					end,
					desc = "Select Scratch Buffer",
				},
				{
					"<leader>n",
					function()
						Snacks.notifier.show_history()
					end,
					desc = "Notification History",
				},
				{
					"<leader>bd",
					function()
						Snacks.bufdelete()
					end,
					desc = "Delete Buffer",
				},
				{
					"<leader>cR",
					function()
						Snacks.rename.rename_file()
					end,
					desc = "Rename File",
				},
				{
					"<leader>gB",
					function()
						Snacks.gitbrowse()
					end,
					desc = "Git Browse",
					mode = { "n", "v" },
				},
				{
					"<leader>gg",
					function()
						Snacks.lazygit()
					end,
					desc = "Lazygit",
				},
				{
					"<leader>un",
					function()
						Snacks.notifier.hide()
					end,
					desc = "Dismiss All Notifications",
				},
				{
					"<c-/>",
					function()
						Snacks.terminal()
					end,
					desc = "Toggle Terminal",
				},
				{
					"]]",
					function()
						Snacks.words.jump(vim.v.count1)
					end,
					desc = "Next Reference",
					mode = { "n", "t" },
				},
				{
					"[[",
					function()
						Snacks.words.jump(-vim.v.count1)
					end,
					desc = "Prev Reference",
					mode = { "n", "t" },
				},
			},
			init = function()
				vim.api.nvim_create_autocmd("User", {
					pattern = "VeryLazy",
					callback = function()
						-- Setup some globals for debugging (lazy-loaded)
						_G.dd = function(...)
							Snacks.debug.inspect(...)
						end
						_G.bt = function()
							Snacks.debug.backtrace()
						end
						vim.print = _G.dd -- Override print to use snacks for `:=` command

						-- Create some toggle mappings
						Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
						Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
						Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
						Snacks.toggle.diagnostics():map("<leader>ud")
						Snacks.toggle.line_number():map("<leader>ul")
						Snacks.toggle
							.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
							:map("<leader>uc")
						Snacks.toggle.treesitter():map("<leader>uT")
						Snacks.toggle
							.option("background", { off = "light", on = "dark", name = "Dark Background" })
							:map("<leader>ub")
						Snacks.toggle.inlay_hints():map("<leader>uh")
						Snacks.toggle.indent():map("<leader>ug")
						Snacks.toggle.dim():map("<leader>uD")
					end,
				})
			end,
		},
		-- do i wanna add a keymap to (en/dis)able
		{
			'MeanderingProgrammer/render-markdown.nvim',
			dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' }, -- if you use standalone mini plugins
			---@module 'render-markdown'
			---@type render.md.UserConfig
			opts = {},
		},
		-- idk abt it 
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
			local ls = require("luasnip")
			vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
			vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
			vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})
			vim.keymap.set({"i", "s"}, "<C-E>", function()
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end, {silent = true})
		},

		-- end of pplugin thingy
	},

	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "catppuccin-latte" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})

vim.cmd("colorscheme rose-pine-dawn")
-- Removes status line highlighting
--vim.cmd(":hi statusline guibg=NONE")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
-- need to figure out the lsp stuff thingy so i can start using neovim as my main code editor

-- LSP native config
-- local lsp_configs = {}
--
-- for _, f in pairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
-- 	local server_name = vim.fn.fnamemodify(f, ":t:r")
-- 	table.insert(lsp_configs, server_name)
-- end
--
-- vim.lsp.enable(lsp_configs)
