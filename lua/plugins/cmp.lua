-- lua/plugins/cmp.lua
return {
  -- nvim-cmp 本体と関連プラグインの設定
  {
    "hrsh7th/nvim-cmp",
    version = false,
    lazy = false,
    priority = 100,
    event = "InsertEnter", -- インサートモードに入った時にロード
    dependencies = {
      -- ソース
      "hrsh7th/cmp-nvim-lsp",   -- LSPからの補完
      "hrsh7th/cmp-buffer",   -- 現在のバッファからの補完
      "hrsh7th/cmp-path",     -- ファイルパス補完
      "hrsh7th/cmp-cmdline",  -- コマンドライン補完
      -- スニペットエンジン連携
      "L3MON4D3/LuaSnip",        -- スニペットエンジン本体
      "saadparwaiz1/cmp_luasnip",-- nvim-cmpからLuaSnipを使うためのブリッジ
      "rafamadriz/friendly-snippets", -- 一般的なスニペット集
      -- UI/UX向上
      "onsails/lspkind.nvim",   -- 補完候補にアイコンを表示
      -- Rust用 (crates.nvim は別で定義するが、依存として挙げておくのも良い)
      -- "saecki/crates.nvim",
    },
    opts = function(_, opts)
      -- この関数内でLazyVimのデフォルト opts テーブルをカスタマイズします
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      local luasnip = require("luasnip") -- Luasnipもここでrequireしておく

      -- 1. 補完ソースの優先順位など
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 },
        { name = "luasnip", priority = 750 },
        { name = "buffer", priority = 500 },
        { name = "path", priority = 250 },
        -- crates ソースは後ほど filetype 設定で追加
      })

      -- 2. スニペットエンジン (LuaSnip) との連携設定
      opts.snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- スニペットを展開する関数を指定
        end,
      }

      -- 3. 補完ウィンドウの見た目 (枠線など)
      opts.window = {
        completion = cmp.config.window.bordered({
          -- ハイライトグループはお好みで調整してください
           winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
        }),
        documentation = cmp.config.window.bordered({
           winhighlight = "Normal:CmpDoc,FloatBorder:CmpDocBorder",
        }),
      }

      -- 4. 補完候補のフォーマット (lspkindでアイコン表示)
      opts.formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text", -- アイコンとテキストを表示
          maxwidth = 50,      -- 表示幅の最大値
          ellipsis_char = "...", -- 長すぎる場合に表示される省略記号
          -- 各ソース名の表示を設定 (お好みで)
          menu = {
            buffer = "[Buf]",
            nvim_lsp = "[LSP]",
            luasnip = "[Snip]",
            path = "[Path]",
            crates = "[Crates]", -- crates.nvim 用
          },
        }),
      }

      -- 5. キーマッピング (インサートモードでの操作)
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- ドキュメントを上にスクロール
        ["<C-f>"] = cmp.mapping.scroll_docs(4),  -- ドキュメントを下にスクロール
        ["<C-Space>"] = cmp.mapping.complete(),  -- 補完を手動でトリガー
        ["<C-e>"] = cmp.mapping.abort(),         -- 補完を閉じる
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- 候補を選択するが、確定はしない (LSPによっては確定が必要な場合あり)
        -- Tab / S-Tab で候補を選択、スニペットが利用可能な場合はジャンプ
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }), -- インサートモード、セレクトモードで有効
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

       -- 6. ゴーストテキストの有効化 (もしデフォルトで無効なら)
      opts.experimental = opts.experimental or {}
      opts.experimental.ghost_text = true

      -- 変更したoptsテーブルを返すのを忘れないでください
      return opts
    end,

    config = function(_, opts)
      -- この関数は opts が設定された後に実行されます
      -- opts で設定しきれない詳細設定や、他の setup 関数の呼び出しを行います
      local cmp = require("cmp")

      -- 1. まず opts で設定された内容で nvim-cmp をセットアップ
      cmp.setup(opts)

      -- 2. ファイルタイプごとのソース設定 (C/C++ と Rust)
      --    opts.sources をベースに、ファイルタイプに応じて調整します
      cmp.setup.filetype({ "c", "cpp" }, {
        sources = cmp.config.sources({ -- C/C++ では crates を除外
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
      })
      cmp.setup.filetype("rust", {
        sources = cmp.config.sources({ -- Rust では crates を追加
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750 },
          { name = "crates", priority = 600 }, -- crates.nvim のソース
          { name = "buffer", priority = 500 },
          { name = "path", priority = 250 },
        }),
      })

      -- 3. コマンドライン補完の設定 (':' と '/')
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },         -- パス補完
          { name = "cmdline" },    -- コマンド履歴など
        }),
      })
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },     -- バッファ内の単語で検索補完
        },
      })

      -- 4. スニペットのロード (friendly-snippets を使う場合)
      require("luasnip.loaders.from_vscode").lazy_load()
      -- 必要に応じて特定のファイルタイプへのスニペット割り当てを強化
      -- require("luasnip").filetype_extend("c", { "c" })
      -- require("luasnip").filetype_extend("cpp", { "cpp" })
      -- require("luasnip").filetype_extend("rust", { "rust" })
    end,
  },

  -- crates.nvim: RustのCargo.toml依存関係補完用プラグイン
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" }, -- Cargo.tomlを開いた時にロード
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup({
        completion = {
          cmp = {
            enabled = true, -- nvim-cmp連携を有効化
          },
        },
        -- ポップアップウィンドウの見た目など、お好みで設定
        popup = {
          border = "rounded",
        },
      })
    end,
  },
}
