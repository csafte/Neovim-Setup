return {
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
					local capabilities = require("cmp_nvim_lsp").default_capabilities()
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
      },
		},
    config = function(_, opts)
			require("mason-lspconfig").setup(opts)
			local lspconfig = require("lspconfig")
			local configs = require("lspconfig.configs")

			if not configs["ahk2"] then
				configs["ahk2"] = {
					default_config = {
						cmd = {
							"node",
							"C:\\Tools\\vscode-autohotkey-v2-lsp\\server\\dist\\server.js",
							"--stdio",
						},
						filetypes = { "ahk", "autohotkey", "ah2" },
						init_options = {
							locale = "en-us",
							InterpreterPath = "C:/Program Files/AutoHotkey/UX/AutoHotkeyUX.exe", -- AHK v2 실행 파일 경로
						},
						single_file_support = true,
					},
				}
			end

			-- 정의한 ahk2 서버 실행
			lspconfig.ahk2.setup({
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				-- 스크린샷의 on_attach 기능이 필요하면 여기에 추가
			})
		end,
	},
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
	{
		"mfussenegger/nvim-dap",
		config = function()
			-- 일반 중단점 (Red Circle)
			vim.fn.sign_define("DapBreakpoint", {
				text = "🔴",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "DapBreakpoint",
			})
			-- 조건부 중단점 (Yellow Circle)
			vim.fn.sign_define("DapBreakpointCondition", {
				text = "🟡",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "DapBreakpoint",
			})
			-- 거부된 중단점 (No Entry / Circle with Slash)
			vim.fn.sign_define("DapBreakpointRejected", {
				text = "🚫",
				texthl = "DapBreakpoint",
				linehl = "",
				numhl = "DapBreakpoint",
			})
			-- 현재 실행 위치 (Play Button)
			vim.fn.sign_define("DapStopped", {
				text = "▶️",
				texthl = "DapStopped",
				linehl = "DapStoppedLine",
				numhl = "DapStopped",
			})
			-- 로그 포인트 (Notebook/Memo)
			vim.fn.sign_define("DapLogPoint", {
				text = "📝",
				texthl = "DapLogPoint",
				linehl = "",
				numhl = "DapLogPoint",
			})
		end,
		dependencies = {
			{
				"rcarriga/nvim-dap-ui",
				dependencies = { "nvim-neotest/nvim-nio" },
				opts = {},
				config = function(_, opts)
					local dap = require("dap")
					local dapui = require("dapui")
					dapui.setup(opts)
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
				"local-lua-debugger-vscode",
			},
			automatic_installation = true,
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				python = function(config)
					config.adapters = {
						type = "executable",
						command = "python",
						args = { "-m", "debugpy.adapter" },
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		},
	},
}
