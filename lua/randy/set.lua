local opt = vim.opt

opt.guicursor = ""

opt.nu = true
--opt.numbers = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

--opt.scrolloff = 8 -- Keep cursor 8 lines/columns ahead before scrolling
opt.signcolumn = 'yes' -- Always show the sign column, otherwise it would shift the text
opt.virtualedit = "all"
opt.isfname:append("@-@") -- ??

opt.updatetime = 50

opt.colorcolumn = "80"

opt.guifont = "Iosevka:h10"

opt.clipboard = '' -- Separate neovim and system clipboard
opt.conceallevel = 0 -- So that `` is visible in markdown files
opt.fileencoding = 'utf-8' -- The encoding written to a file
opt.mouse = 'a' -- Enable mouse mode
opt.cursorline = false -- Highlight the text line of the cursor
opt.breakindent = true -- Enable break indent
opt.formatoptions = "jcroqlnt" -- tcqj
opt.cmdheight = 1
opt.undolevels = 10000
opt.confirm = true -- Ask to save unsaved hidden buffers when quitting the app
opt.ignorecase = true
opt.smartcase = true -- Case insensitive searching UNLESS /C or capital in search
opt.spelllang = { "en" } -- set the default languages for spell checking
opt.timeoutlen = 300
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.listchars = 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
opt.showmode = false -- We don't need to see things like -- INSERT -- anymore
opt.showtabline = 1 -- Show tabs only if there are at least two tab pages
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.spell = true -- Spell check in comments
opt.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
opt.sidescroll = 8

opt.foldcolumn = '0'
opt.foldlevel = 99 -- using ufo provider needs a large value
--opt.foldelevelstart = 99
opt.foldenable = true

-- opt.winbar = "%f"
-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Hide the banner in netrw
vim.g.netrw_banner = false
vim.g.netrw_browse_split = 0
--vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
-- vim.g.loaded_2html_plugin = true -- disable 2html
-- vim.g.loaded_getscript = true -- disable getscript
-- vim.g.loaded_getscriptPlugin = true -- disable getscript
-- vim.g.loaded_gzip = true -- disable gzip
-- vim.g.loaded_logipat = true -- disable logipat
-- vim.g.loaded_matchit = true -- disable matchit
-- vim.g.loaded_netrwFileHandlers = true -- disable netrw
-- vim.g.loaded_netrwPlugin = true -- disable netrw
-- vim.g.loaded_netrwSettngs = true -- disable netrw
-- vim.g.loaded_remote_plugins = true -- disable remote plugins
-- vim.g.loaded_tar = true -- disable tar
-- vim.g.loaded_tarPlugin = true -- disable tar
-- vim.g.loaded_zip = true -- disable zip
-- vim.g.loaded_zipPlugin = true -- disable zip
-- vim.g.loaded_vimball = true -- disable vimball
-- vim.g.loaded_vimballPlugin = true -- disable vimball

