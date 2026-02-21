require("config.lazy")

-- appearance
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.cursorline = true

-- statusline
vim.opt.showcmd = true
vim.opt.cmdheight = 2
vim.opt.laststatus = 2

-- encoding
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "euc-jp", "sjis", "iso-2022-jp" }

-- clipboard
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

-- search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = true

-- indent
vim.opt.tabstop = 2
vim.opt.shiftwidth= 2
vim.opt.softtabstop= 2
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true

vim.opt.splitright = true
