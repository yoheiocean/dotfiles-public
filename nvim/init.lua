-- Neovim config — minimal, terminal-native

-- Leader key (set before any mappings)
vim.g.mapleader = " "

---------- Options ----------

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation (2 spaces, expand tabs)
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Clipboard (use system clipboard)
vim.opt.clipboard = "unnamedplus"

-- UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false
vim.opt.showmode = false
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Files
vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 250

-- Whitespace visibility
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

---------- Plugin manager (lazy.nvim) ----------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.g.gruvbox_material_transparent_background = 1
      vim.g.gruvbox_material_better_performance = 1
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
})

---------- Keymaps ----------

local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Move lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Better paste (don't yank replaced text)
map("x", "p", '"_dP')

---------- Filetype overrides ----------

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
