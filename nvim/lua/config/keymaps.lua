local function close_current_buffer_keep_nvim()
  local current = vim.api.nvim_get_current_buf()
  local listed = vim.fn.getbufinfo({ buflisted = 1 })

  if #listed > 1 then
    vim.cmd("bprevious")
    vim.cmd("bdelete " .. current)
  else
    vim.cmd("enew")
    vim.cmd("bdelete " .. current)
  end
end

vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle explorer" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>t", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })

vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Problems panel" })
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer problems" })
vim.keymap.set("n", "<leader>w", close_current_buffer_keep_nvim, { desc = "Close buffer" })
vim.keymap.set("n", "<leader>]", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>[", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit window" })

vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>", { desc = "Quick open" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go up window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go right window" })
