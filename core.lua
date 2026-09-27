-- BASIC CONFIGURATION
local home = os.getenv("HOME")
local swap_dir = home .. "/.local/state/nvim/swap"
local backup_dir = home .. "/.local/state/nvim/backup"
local undo_dir = home .. "/.local/state/nvim/undo"
vim.fn.mkdir(swap_dir, "p")
vim.fn.mkdir(backup_dir, "p")
vim.fn.mkdir(undo_dir, "p")

vim.opt.number = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.ruler = true
vim.opt.undolevels = 2000
vim.opt.undoreload = 20000
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.swapfile = true
vim.opt.directory = swap_dir .. "//"
vim.opt.backup = true
vim.opt.backupdir = backup_dir .. "//"
vim.opt.undofile = true
vim.opt.undodir = undo_dir .. "//"
vim.opt.termguicolors = true
vim.opt.updatetime = 500
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.foldmethod = "indent"
vim.opt.showmode = false

-- AUTOSAVE
local autosave_group = vim.api.nvim_create_augroup("AutoSaveGroup", { clear = true })
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertLeave" }, {
  group = autosave_group,
  pattern = "*",
  callback = function(args)
    local buf = args.buf
    if not vim.api.nvim_buf_is_valid(buf) then
      return
    end
    local is_modified = vim.bo[buf].modified
    local has_name = vim.api.nvim_buf_get_name(buf) ~= ""
    local is_normal_buffer = vim.bo[buf].buftype == ""
    if is_modified and has_name and is_normal_buffer then
      vim.cmd.update({ mods = { silent = true } })
    end
  end,
})

-- TREESITTER
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- DIAGNOSTICS CONFIGURATION
local diagnostic_symbols = {
  error = "■",
  warn = "▲",
  info = "●",
  hint = "◆",
}

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = diagnostic_symbols.error,
      [vim.diagnostic.severity.WARN] = diagnostic_symbols.warn,
      [vim.diagnostic.severity.INFO] = diagnostic_symbols.info,
      [vim.diagnostic.severity.HINT] = diagnostic_symbols.hint,
    },
  },

  virtual_text = {
    spacing = 4,
    prefix = "",
    source = "if_many",
    format = function(diagnostic)
      local icon = diagnostic_symbols.error
      if diagnostic.severity == vim.diagnostic.severity.WARN then
        icon = diagnostic_symbols.warn
      elseif diagnostic.severity == vim.diagnostic.severity.INFO then
        icon = diagnostic_symbols.info
      elseif diagnostic.severity == vim.diagnostic.severity.HINT then
        icon = diagnostic_symbols.hint
      end
      return string.format("%s %s", icon, diagnostic.message)
    end,
  },

  virtual_lines = {
    current_line = false,
  },

  update_in_insert = false,
  underline = true,
  severity_sort = true,

  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})
