return {
	-- lsp 설정
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls", -- Lua
				"clangd", -- C/C++
				"neocmake", -- CMake
				"cssls", -- CSS
				"html", -- HTML
				"emmet_ls", -- HTML/CSS Emmet
				"ts_ls", -- TypeScript/JavaScript
				"pyright", -- Python
				"rust_analyzer", -- Rust
				"jdtls", -- Java
			},
			automatic_installation = true,
			handlers = {
				function(server_name)
					-- nvim-cmp와 LSP 통합을 위한 capabilities 설정
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- Lua LSP 특별 설정
			},
		},
	},
	-- formatter 및 linter 설치
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"mason-org/mason.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvimtools/none-ls.nvim", version = "*" },
		},
		opts = {
			ensure_installed = {
				"clang-format",
				"black",
				"stylua",
				"isort",
				"cpplint",
				"prettier",
				"ast-grep",
				"flake8",
				"htmlhint",
				"stylelint",
				"eslint",
			},
			automatic_installation = true,
			handlers = {
				function(source_name, methods)
					require("mason-null-ls.automatic_setup")(source_name, methods)
				end,
			},
		},
		config = function(_, opts)
			local null_ls = require("null-ls")
			null_ls.setup()
			require("mason-null-ls").setup(opts)
		end,
	},
	-- formatter 실제 적용
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				cmake = { "cmakelang" },
				python = { "black", "isort" },
				lua = { "stylua" },
				java = { "google-java-format" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				rust = { "rustfmt" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
	},
	-- linter 실제 적용
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				c = { "cpplint" },
				cpp = { "cpplint" },
				cmake = { "cmakelint" },
				python = { "flake8" },
				java = { "checkstyle" },
				html = { "htmlhint" },
				css = { "stylelint" },
				javascript = { "eslint" },
				typescript = { "eslint" },
			}
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
			vim.keymap.set("n", "<leader>l", function()
				lint.try_lint()
			end, { desc = "Trigger linting for current file" })
		end,
	},
	-- DAP (Debug Adapter Protocol) 코어
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- 브레이크포인트 아이콘 설정
			vim.fn.sign_define("DapBreakpoint", {
				text = "🔴",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapBreakpointCondition", {
				text = "🟡",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapBreakpointRejected", {
				text = "🚫",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "DapBreakpoint",
			})
			vim.fn.sign_define("DapStopped", {
				text = "▶️",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
				numhl = "DapStopped",
			})
			vim.fn.sign_define("DapLogPoint", {
				text = "📝",
				texthl = "DapLogPoint",
				linehl = "",
				numhl = "DapLogPoint",
			})
		end,
		dependencies = {
			-- DAP UI
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				opts = {},
				config = function(_, opts)
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup(opts)
					-- DAP 이벤트 시 자동으로 UI 열기/닫기
					dap.listeners.after.event_initialized["dapui_config"] = function()
						dapui.open()
					end
					dap.listeners.before.event_terminated["dapui_config"] = function()
						dapui.close()
					end
					dap.listeners.before.event_exited["dapui_config"] = function()
						dapui.close()
					end
				end,
			},
			-- Virtual text로 변수 값 표시
			{
				"theHamsta/nvim-dap-virtual-text",
				opts = {},
			},
		},
		keys = {
			{
				"<leader>db",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Continue",
			},
			{
				"<leader>di",
				function()
					require("dap").step_into()
				end,
				desc = "Step Into",
			},
			{
				"<leader>do",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			{
				"<leader>dO",
				function()
					require("dap").step_out()
				end,
				desc = "Step Out",
			},
			{
				"<leader>dr",
				function()
					require("dap").repl.toggle()
				end,
				desc = "Toggle REPL",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run Last",
			},
			{
				"<leader>dt",
				function()
					require("dap").terminate()
				end,
				desc = "Terminate",
			},
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle DAP UI",
			},
		},
	},
	-- Mason을 통한 디버거 자동 설치
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			ensure_installed = {
				"codelldb", -- C/C++/Rust
				"debugpy", -- Python
				"js-debug-adapter", -- JavaScript/TypeScript
				"java-debug-adapter", -- Java
        "local-lua-debugger-vscode"
			},
			automatic_installation = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				-- Python 특별 설정
				python = function(config)
					config.adapters = {
						type = "executable",
						command = "python",
						args = { "-m", "debugpy.adapter" },
					}
					require("mason-nvim-dap").default_setup(config)
				end,
				-- Lua 특별 설정
			},
		},
	},
}
