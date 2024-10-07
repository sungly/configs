return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		vim.keymap.set("n", "<C-n>", "<Cmd>Neotree toggle<CR>")
		local events = require("neo-tree.events")
		events.fire_event(events.GIT_EVENT)
	end,
}
