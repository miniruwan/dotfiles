local treesitter_ensure_installed = {
  "bash",
  "c",
  "cpp",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "query",
  "typescript",
  "vim",
  "vimdoc",
}

return {
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup({ style = "darker" })
      require("onedark").load()
      vim.api.nvim_set_hl(0, "MatchParen", { bold = true, fg = "#ffffaa", bg = "#5c6370" })
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "onedark",
        globalstatus = true,
      },
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>nn", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      { "<leader>nf", "<cmd>NvimTreeFindFile<CR>", desc = "Find current file in tree" },
    },
    opts = {
      update_focused_file = {
        enable = true,
      },
      view = {
        width = 34,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>p", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>f", "<cmd>Telescope grep_string<CR>", desc = "Search word under cursor" },
      { "<leader>ft", "<cmd>Telescope grep_string<CR>", desc = "Search word under cursor" },
      { "<leader>fs", "<cmd>Telescope live_grep<CR>", desc = "Search text" },
      { "<leader>o", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
      { "<leader>c", "<cmd>Telescope git_status<CR>", desc = "Changed files" },
      { "<leader>tt", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>fr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "yank_history")
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = function(plugin)
      vim.fn.delete(plugin.dir .. "/parser", "rf")
      require("nvim-treesitter").install(treesitter_ensure_installed):wait(300000)
    end,
    opts = {
      ensure_installed = treesitter_ensure_installed,
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      local treesitter = require("nvim-treesitter")
      treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

      local filetypes = vim.list_extend(vim.deepcopy(opts.ensure_installed), { "sh" })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function()
          if opts.highlight and opts.highlight.enable then
            pcall(vim.treesitter.start)
          end

          if opts.indent and opts.indent.enable then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("config.plugin_configs.lsp")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("config.plugin_configs.completion")
    end,
  },
  {
    "numToStr/Comment.nvim",
    keys = { "gc", "gb" },
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local ok, cmp = pcall(require, "cmp")
      if ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
    opts = {},
  },
  {
    "echasnovski/mini.align",
    version = false,
    keys = { "ga", "gA" },
    opts = {},
  },
  {
    "gbprod/yanky.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
      { "<leader>ps", "<cmd>Telescope yank_history<CR>", desc = "Yank history" },
    },
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gitsigns = require("gitsigns")
        local function buffer_map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = buffer, desc = desc })
        end

        buffer_map("n", "]c", gitsigns.next_hunk, "Next git hunk")
        buffer_map("n", "[c", gitsigns.prev_hunk, "Previous git hunk")
        buffer_map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
        buffer_map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")
        buffer_map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
        buffer_map("n", "<leader>hb", gitsigns.blame_line, "Blame line")
      end,
    },
  },
  {
    "stevearc/aerial.nvim",
    keys = {
      { "<leader>r", "<cmd>AerialToggle<CR>", desc = "Toggle symbols" },
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown" },
    },
  },
  {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>py",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        cpp = { "clang_format" },
        css = { "prettier" },
        html = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier" },
        python = { "black" },
        sh = { "shfmt" },
        typescript = { "prettier" },
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}