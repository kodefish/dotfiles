return {
	"folke/trouble.nvim",
	config = function()
		local keys = vim.keymap -- for conciceness
		keys.set("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document diagnostics" })
		keys.set("n", "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace diagnostics" })
		keys.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix list (Trouble window)" })
	end,
}
