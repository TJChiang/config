return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        width = 35,
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
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
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        progress = { enabled = true },
        hover = { enabled = true },
        signature = { enabled = true },
      },
    },
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      background_colour = "#1e1e1e",
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      size = 16,
      open_mapping = [[<c-\>]],
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
    },
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        show_close_icon = false,
        show_buffer_close_icons = false,
        separator_style = "thin",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        theme = "vscode",
        section_separators = "",
        component_separators = "",
      },
    },
  },
  {
    "folke/trouble.nvim",
    opts = {},
  },
  {
    "numToStr/Comment.nvim",
    opts = {},
  },
}
