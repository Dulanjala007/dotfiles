--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general

lvim.format_on_save = true
lvim.lint_on_save = true
lvim.colorscheme = "darkplus"

-- keymappings
lvim.leader = "space"

vim.cmd([[
nnoremap Y y$

" paste on cursor
nnoremap gP i<CR><Esc>PkJxJx
nnoremap gp a<CR><Esc>PkJxJx

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP
]])
-- overwrite the key-mappings provided by LunarVim for any mode, or leave it empty to keep them
-- lvim.keys.normal_mode = {
--   Page down/up
--   {'[d', '<PageUp>'},
--   {']d', '<PageDown>'},
--
--   Navigate buffers
--   {'<Tab>', ':bnext<CR>'},
--   {'<S-Tab>', ':bprevious<CR>'},
-- }
-- if you just want to augment the existing ones then use the utility function
-- require("utils").add_keymap_insert_mode({ silent = true }, {
-- { "<C-s>", ":w<cr>" },
-- { "<C-c>", "<ESC>" },
-- })
-- you can also use the native vim way directly
-- vim.api.nvim_set_keymap("i", "<C-Space>", "compe#complete()", { noremap = true, silent = true, expr = true })

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.rooter.active = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = "maintained"
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- python

-- LSP
lvim.lsp.diagnostics.virtual_text = false
lvim.lsp.override = { "java" }
require("user.json_schemas").setup()

lvim.plugins = {
	{ "lunarvim/colorschemes" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("user.colorizer").config()
		end,
		event = "BufRead",
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("user.indent_blankline").config()
		end,
	},
	"tpope/vim-repeat",
	{
		"ggandor/lightspeed.nvim",
		event = "BufRead",
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "InsertEnter",
		config = function()
			require("user.lsp_signature").config()
		end,
	},
	{
		"windwp/nvim-spectre",
		event = "BufRead",
		config = function()
			require("user.spectre").config()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
	},
	{
		"folke/zen-mode.nvim",
		config = function()
			require("user.zen").config()
		end,
	},
	{
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		"kevinhwang91/nvim-bqf",
		event = "BufRead",
	},
}

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"}, {
--         "ray-x/lsp_signature.nvim",
--         config = function() require"lsp_signature".on_attach() end,
--         event = "InsertEnter"
--     }
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- Whichkey
lvim.builtin.which_key.mappings["F"] = {
	"<cmd>lua require'user.telescope'.find_files_with_hidden{}<CR>",
	"Find File +Hidden",
}
lvim.builtin.which_key.mappings.l.d = { "<cmd>TroubleToggle<cr>", "Diagnostics" }
lvim.builtin.which_key.mappings.l.R = { "<cmd>TroubleToggle lsp_references<cr>", "References" }
lvim.builtin.which_key.mappings.l.o = { "<cmd>SymbolsOutline<cr>", "Outline" }
lvim.builtin.which_key.mappings["z"] = { "<cmd>ZenMode<cr>", "Zen" }
lvim.builtin.which_key.mappings["r"] = {
	name = "Replace",
	r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
	w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
	f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
}
-- Additional Leader bindings for WhichKey
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }
