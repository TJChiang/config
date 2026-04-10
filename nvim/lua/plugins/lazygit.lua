return {
  {
    "kdheepak/lazygit.nvim",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
      "LazyGitLog",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gG", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gg", "<cmd>LazyGitCurrentFile<cr>", desc = "LazyGit Current File" },
      { "<leader>gl", "<cmd>LazyGitLog<cr>", desc = "LazyGit Log" },
    },
  },
}
