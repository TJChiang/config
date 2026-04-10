return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        java = { "google-java-format" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        python = { "isort", "black" },
        go = { "goimports", "gofumpt" },
        json = { "prettierd", "prettier", stop_after_first = true },
        jsonc = { "prettierd", "prettier", stop_after_first = true },
        yaml = { "yamlfmt" },
        markdown = { "mdformat" },
        toml = { "taplo" },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "google-java-format",
        "prettierd",
        "prettier",
        "isort",
        "black",
        "goimports",
        "gofumpt",
        "yamlfmt",
        "mdformat",
        "taplo",
      },
    },
  },
}
