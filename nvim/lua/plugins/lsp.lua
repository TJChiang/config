local function extend_unique(list, items)
  for _, item in ipairs(items) do
    if not vim.tbl_contains(list, item) then
      table.insert(list, item)
    end
  end
end

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      extend_unique(opts.ensure_installed, {
        "clangd",
        "gopls",
        "intelephense",
        "jdtls",
        "lua-language-server",
        "pyright",
        "typescript-language-server",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {},
        gopls = {},
        intelephense = {},
        jdtls = {
          root_dir = function(fname)
            local util = require("lspconfig.util")
            return util.root_pattern(".git", "mvnw", "gradlew", "pom.xml", "build.gradle")(fname)
          end,
          single_file_support = false,
        },
        lua_ls = {
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
        },
        pyright = {},
        ts_ls = {},
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      extend_unique(opts.ensure_installed, {
        "bash",
        "cpp",
        "go",
        "java",
        "javascript",
        "json",
        "lua",
        "php",
        "python",
        "query",
        "vim",
        "vimdoc",
        "yaml",
      })
    end,
  },
}
