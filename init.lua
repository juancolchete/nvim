vim.cmd [[set number]]
vim.cmd [[call plug#begin('~/.local/share/nvim/plugged')]]
vim.cmd [[Plug 'wakatime/vim-wakatime']]
vim.cmd [[Plug 'kdheepak/lazygit.nvim']]
vim.cmd [[Plug 'goolord/alpha-nvim']]
vim.cmd [[Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}]]
vim.cmd [[Plug 'nvim-tree/nvim-tree.lua']]
vim.cmd [[Plug 'nvim-lualine/lualine.nvim']]
vim.cmd [[Plug 'nvim-tree/nvim-web-devicons']]
vim.cmd [[Plug 'akinsho/toggleterm.nvim']]
vim.cmd [[Plug 'nvim-lua/plenary.nvim']]
vim.cmd [[Plug 'nvim-telescope/telescope.nvim']]
vim.cmd [[call plug#end()]]

vim.g.mapleader = " "
vim.keymap.set('n','<leader>e','<cmd>NvimTreeToggle<CR>')
vim.keymap.set('n','<leader>gg','<cmd>LazyGit<CR>')
vim.keymap.set('n','<leader>w','<cmd>write<CR>')
vim.keymap.set('n','<leader>f','<cmd>Telescope find_files<cr>')
vim.keymap.set('n','<S-f>','<cmd>Telescope live_grep<cr>')
vim.keymap.set('n','<F2>','<cmd>ToggleTerm direction=float<CR>')
vim.keymap.set('t','<F2>','<cmd>ToggleTerm direction=float<CR>')
vim.keymap.set('n','<F3>','<cmd>ToggleTerm direction=horizontal<CR>')
vim.keymap.set('t','<F3>','<cmd>ToggleTerm direction=horizontal<CR>')
vim.keymap.set('n','<F4>','<cmd>ToggleTerm direction=vertical<CR>')
vim.keymap.set('t','<F4>','<cmd>ToggleTerm direction=vertical<CR>')
vim.keymap.set('n','<A-j>',':m .+1<CR>==')
vim.keymap.set('n','<A-k>',':m .-2<CR>==')
vim.keymap.set('v','<A-j>',':m .+1<CR>==')
vim.keymap.set('v','<A-k>',':m .-2<CR>==')
local uv = vim.uv

local function setInterval(interval,callback)
	local timer = uv.new_timer()
	timer:start(interval,interval,function()
		callback()
	end)
	return timer
end

setInterval(10000,function ()
	local openPop = assert(io.popen('~/.wakatime/wakatime-cli --today','r'))
	wakatime = openPop:read('*all')
	wakatime = string.sub(wakatime, 0, string.len(wakatime) -1)
	openPop:close()
end)


local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
alpha.setup(dashboard.config)
local nvimTree = require'nvim-tree'
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename','os.date("%d/%m/%Y %H:%M:%S")','wakatime'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
nvimTree.setup()
require("toggleterm").setup()
require("telescope").setup()
