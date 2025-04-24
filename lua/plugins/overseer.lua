return {
  {
    "stevearc/overseer.nvim",
    cmd = {
      "OverseerOpen",
      "OverseerClose",
      "OverseerToggle",
      "OverseerSaveBundle",
      "OverseerLoadBundle",
      "OverseerRunCmd",
      "OverseerRun",
      "OverseerInfo",
    },
    keys = {
      { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Toggle Overseer" },
      { "<leader>or", "<cmd>OverseerRun<cr>", desc = "Run Overseer Task" },
    },
    config = function()
      require("overseer").setup({
        -- Overseerの設定をここに記述
        templates = { "builtin" }, -- ビルトインのテンプレートを使用
        task_list = {
          direction = "bottom", -- タスクリストの表示位置
          min_height = 10, -- 最小の高さ
          max_height = 20, -- 最大の高さ
          bindings = {
            ["?"] = "ShowHelp",
            ["<CR>"] = "RunAction",
            ["<C-e>"] = "Edit",
            ["o"] = "Open",
            ["<C-v>"] = "OpenVsplit",
            ["<C-s>"] = "OpenSplit",
            ["<C-f>"] = "OpenFloat",
            ["<C-q>"] = "QuickFix",
            ["p"] = "TogglePreview",
            ["+"] = "IncreaseDetail",
            ["-"] = "DecreaseDetail",
            ["<C-l>"] = "IncreaseAllDetail",
            ["<C-h>"] = "DecreaseAllDetail",
            ["["] = "DecreaseWidth",
            ["]"] = "IncreaseWidth",
            ["{"] = "PrevTask",
            ["}"] = "NextTask",
          },
        },
      })
    end,
  },
}
