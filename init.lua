vim.cmd [[set number]]
vim.cmd [[call plug#begin('~/.local/share/nvim/plugged')]]
vim.cmd [[Plug 'wakatime/vim-wakatime']]
vim.cmd [[Plug 'kdheepak/lazygit.nvim']]
vim.cmd [[Plug 'goolord/alpha-nvim']]
vim.cmd [[Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}]]
vim.cmd [[call plug#end()]]

local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
alpha.setup(dashboard.config)
