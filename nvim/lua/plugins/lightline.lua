return {
  -- https://github.com/itchyny/lightline.vim
  "itchyny/lightline.vim",
  lazy = false,
  init = function()
    vim.g.lightline = {
      colorscheme = "darcula",
      active = {
        left = { { "mode", "paste" }, { "gitbranch", "readonly", "filename", "modified" } },
        right = { { "lineinfo" }, { "percent" }, { "fileformat", "fileencoding", "filetype" } },
      },
      inactive = {
        left = { { "filename", "modified" } },
        right = { { "lineinfo" }, { "filetype" } },
      },
    }
  end
}
