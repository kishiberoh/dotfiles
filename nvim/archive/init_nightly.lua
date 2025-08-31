vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o' , ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w' , ':write<CR>')
vim.keymap.set('n', '<leader>q' , ':quit<CR>')


vim.pack.add({
		{src = "https://github.com/catppuccin/nvim"},
		{ src = "https://github.com/stevearc/oil.nvim" },
		{ src = "https://github.com/echasnovski/mini.pick" },
		{ src = 'https://github.com/neovim/nvim-lspconfig' },
		{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})
	
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})


vim.cmd("set completeopt+=noselect")

require "mini.pick".setup()
require "oil".setup()

vim.cmd("LspStart()")
vim.lsp.enable('lua_ls', 'metals')

vim.keymap.set('n', '<leader>lf' , vim.lsp.buf.format) 
vim.keymap.set('n', '<leader>f' , ":Pick files<CR>'")
vim.keymap.set('n', '<leader>h' , ":Pick help<CR>'")
vim.keymap.set('n', '<leader>e' , ":Oil<CR>'")

vim.cmd("colorscheme catppuccin-frappe")
vim.cmd(":hi statusline guibg=NONE")



