-- ============================================================
-- Neovim config: VSCode-like workflow with lazy.nvim
-- LSP: PHP, Python, C++, Go, Java, JavaScript
-- Includes terminal, file explorer, fuzzy finder, completion
-- ============================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Core editor options
vim.opt.number = true               -- Show line numbers.
vim.opt.relativenumber = false      -- Relative line numbers.
vim.opt.cursorline = true           -- Highlight line.
vim.opt.tabstop = 2                 -- Tab width.
vim.opt.shiftwidth = 2              -- Indent width.
vim.opt.expandtab = true            -- Tabs to spaces.
vim.opt.smartindent = true          -- Smart indent.
vim.opt.wrap = false                -- Line wrap.
vim.opt.ignorecase = true           -- Ignore case.
vim.opt.smartcase = true            -- Uppercase = case-sensitive.
vim.opt.hlsearch = false            -- No persistent highlights.
vim.opt.incsearch = true            -- Search as you type.
vim.opt.termguicolors = true        -- True color.
vim.opt.scrolloff = 8               -- Vertical context.
vim.opt.sidescrolloff = 8           -- Horizontal context.
vim.opt.signcolumn = "yes"          -- Always show signs.
vim.opt.updatetime = 250            -- Faster updates.
vim.opt.splitright = true           -- Vsplit right.
vim.opt.splitbelow = true           -- Split below.
vim.opt.mouse = "a"                 -- Mouse enabled.
vim.opt.clipboard = "unnamedplus"   -- System clipboard.

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
      require("vscode").setup({
        transparent = false,
        italic_comments = true,
      })
      vim.cmd.colorscheme("vscode")
    end,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup()
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("notify").setup({
        background_colour = "#1e1e1e",
      })
      vim.notify = require("notify")
      require("noice").setup({
        lsp = {
          progress = { enabled = true },
          hover = { enabled = true },
          signature = { enabled = true },
        },
      })
    end,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        window = {
          width = 35,
        },
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = "  ",
          selection_caret = "  ",
          file_ignore_patterns = { "node_modules", ".git/", "vendor/" },
          layout_config = {
            horizontal = {
              preview_width = 0.58,
            },
          },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua",
          "vim",
          "vimdoc",
          "query",
          "php",
          "python",
          "cpp",
          "go",
          "java",
          "javascript",
          "json",
          "yaml",
          "bash",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      require("mason-lspconfig").setup({
        ensure_installed = {
          "intelephense",
          "pyright",
          "clangd",
          "gopls",
          "jdtls",
          "ts_ls",
          "lua_ls",
        },
      })

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        map("n", "K", vim.lsp.buf.hover, "Hover docs")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, "Format buffer")
      end

      local servers = {
        "intelephense",
        "pyright",
        "clangd",
        "gopls",
        "ts_ls",
      }

      for _, server_name in ipairs(servers) do
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
        })
      end

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              checkThirdParty = false,
            },
          },
        },
      })

      lspconfig.jdtls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        root_dir = util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle"),
        single_file_support = false,
      })
    end,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
      "windwp/nvim-autopairs",
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      require("luasnip.loaders.from_vscode").lazy_load()
      require("nvim-autopairs").setup()
      require("nvim-ts-autotag").setup()

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },

  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 16,
        open_mapping = [[<c-\>]],
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
      })
    end,
  },

  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("bufferline").setup({
        options = {
          diagnostics = "nvim_lsp",
          show_close_icon = false,
          show_buffer_close_icons = false,
          separator_style = "thin",
        },
      })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "vscode",
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
}, {
  checker = { enabled = true },
})

-- Keymaps
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Problems panel" })
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer problems" })
vim.keymap.set("n", "<leader>w", "<cmd>bd<cr>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>]", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>[", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Quick open" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go right window" })

-- Auto format on save when LSP supports it
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local clients = vim.lsp.get_clients({ bufnr = args.buf })
    if #clients > 0 then
      vim.lsp.buf.format({ bufnr = args.buf, async = false })
    end
  end,
})

-- Better diagnostics UX
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "if_many",
  },
})

-- Briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})
