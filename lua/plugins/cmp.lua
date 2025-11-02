-- lua/plugins/cmp.lua (LazyVim用 カスタム設定)
return {
  -- LazyVimのデフォルト設定を上書き
  "hrsh7th/nvim-cmp",
  -- `opts`に関数を渡すことで、デフォルトのオプション(opts)を引数として受け取り、
  -- それを加工して返す、というカスタマイズができます。
  opts = function(_, opts)
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    -- 補完ウィンドウの見た目やキーマッピングなどをカスタム
    opts.window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    }
    opts.mapping = cmp.mapping.preset.insert({
      ["<C-p>"] = cmp.mapping.select_prev_item(), -- 補完メニュー: 前の項目
      ["<C-n>"] = cmp.mapping.select_next_item(), -- 補完メニュー: 次の項目
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = nil, -- LazyVimのデフォルトTabマッピングを無効化する場合
      ["<S-Tab>"] = nil,
    })
    opts.formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
      }),
    }
    -- 変更したoptsを返すのを忘れずに
    return opts
  end,
}
