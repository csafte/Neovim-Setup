return {
	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- set header
		dashboard.section.header.val = {
			"       .,oo8888888888888888ooo,.",
			"    ,od88888888888888888888888888oo,",
			" ,o0MMMMMMMMNMMMMM8888888888888888888o.",
			"d888888888V'.o   ```VoooooooOOOOOOOOIII,",
			"l888LLLLl:  O , ,O    ``VlMM88888IIAMMMMMOMb,",
			"l8888888LLb `VooV',O,MoodlM88888IIIMMMMV'ddMOMb,",
			"l88888888888booooooOlllIIIIIIIIIAMMV',dMMOOMMMb,",
			"888888888888888888LLLLIAMMMMMMMMMMMMMMMMOOOOMMMMMMb,",
			"8M8888888888LLLMMMAAMMMAAMMMMMMMMMMMMMMOOOOMMMMMMMMb",
			"88M8888888lll888888mmmmmmmmmmmmmmvvvvvvvvvvvvv,`MMMM",
			"8888M888888llllllllllllllV::::V''~~        ~~'V lMMV",
			"M8888MMM888888TTTMl8lllllb:::V'                `IiM'",
			"MMMMM8888M8k88888l8Mklllllk:A'                  `V'",
			"lMMMMMM888888888888MMMMMlll:M",
			"l8MM8MMMM8888888888888MMMMllM",
			"l888888888888V`V888888MMMMMMM         .mmmmm,.",
			"88V`V8A8888888 8888MMMlV`VMMM.     .odMMMMMMMObo.",
			"`8' 88 A8 VMM8 `8' `88l' 88`Vb ooodMMMMMMMMMMMMMMb,",
			" : V  0  `OO'    : `0' :`0 `8b`V888888888888888888bvodl",
			"           O'  :          `   `b`V888888888888888888bV8l",
		}
		dashboard.section.buttons.val = {
			dashboard.button("n", "  > New file", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "  > Find file", ":Telescope find_files<CR>"),
			dashboard.button("w", "  > Find Word", ":Telescope live_grep <CR>"),
			dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
			dashboard.button("q", "  > Quit", ":qa<CR>"),
		}

		alpha.setup(dashboard.opts)
	end,
}
