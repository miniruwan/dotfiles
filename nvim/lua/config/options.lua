vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.opt.shell = "/bin/zsh"
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.mouse = "a"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.foldlevelstart = 99
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.switchbuf = { "useopen", "usetab" }
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
vim.opt.iskeyword:append("-")

if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep --smart-case"
  vim.opt.grepformat = "%f:%l:%c:%m"
else
  vim.opt.grepprg = "/usr/bin/grep"
end

if vim.fn.has("clipboard") == 1 then
  vim.opt.clipboard = "unnamedplus"
end

local python3 = vim.fn.exepath("python3")
if python3 ~= "" then
  vim.g.python3_host_prog = python3
end

vim.g.loaded_python_provider = 0