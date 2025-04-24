return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      -- Draculaのカラーパレット
      local colors = {
        bg = "#282a36",
        fg = "#f8f8f2",
        selection = "#44475a",
        comment = "#6272a4",
        red = "#ff5555",
        orange = "#ffb86c",
        yellow = "#f1fa8c",
        green = "#50fa7b",
        purple = "#bd93f9",
        cyan = "#8be9fd",
        pink = "#ff79c6",
      }

      -- Dracula風のカスタムテーマ
      local dracula_theme = {
        normal = {
          a = { fg = colors.bg, bg = colors.purple, gui = "bold" },
          b = { fg = colors.fg, bg = colors.selection },
          c = { fg = colors.fg, bg = colors.bg }
        },
        insert = {
          a = { fg = colors.bg, bg = colors.green, gui = "bold" },
          b = { fg = colors.fg, bg = colors.selection }
        },
        visual = {
          a = { fg = colors.bg, bg = colors.pink, gui = "bold" },
          b = { fg = colors.fg, bg = colors.selection }
        },
        replace = {
          a = { fg = colors.bg, bg = colors.red, gui = "bold" },
          b = { fg = colors.fg, bg = colors.selection }
        },
        command = {
          a = { fg = colors.bg, bg = colors.yellow, gui = "bold" },
          b = { fg = colors.fg, bg = colors.selection }
        },
        inactive = {
          a = { fg = colors.comment, bg = colors.bg, gui = "bold" },
          b = { fg = colors.comment, bg = colors.bg },
          c = { fg = colors.comment, bg = colors.bg }
        }
      }


      return {
        options = {
          theme = dracula_theme,
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { 
            { "filename", path = 1 }  -- ファイル名にパスも表示
          },
          lualine_x = { 
            { "filetype", icon_only = true },
            { "encoding" },
            { "fileformat" }
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },
}
