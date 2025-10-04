return {
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = {}, -- added via mason-tool-installer
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "stylua",
          { "eslint_d", version = "13.1.2" },
          "biome",
          "php-cs-fixer",
          "cssls",
          "html",
          "lua_ls",
          "tailwindcss",
          "pyright",
          "yamlls",
          "jsonls",
          "gopls",
          "dockerls",
          "docker_compose_language_service",
          "intelephense",
          "laravel_ls",
          "volar",
          "ts_ls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      { "folke/neodev.nvim", opts = {} },
    },
    config = function()
      -- Diagnostic signs
      local signs = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = "󰠠 ",
        [vim.diagnostic.severity.INFO] = " ",
      }

      vim.diagnostic.config({
        signs = { text = signs },
        virtual_text = true,
        underline = true,
        update_in_insert = false,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      require("neodev").setup()

      -- Default config for all servers unless overridden
      vim.lsp.config("*", {
        capabilities = capabilities,
        root_markers = { ".git" },
      })

      local function setup_lsp_servers()


        local servers = {
          tsserver = {},
          tailwindcss = {},
          html = {},
          cssls = {},
          volar = {
            filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
          },
          lua_ls = {
            settings = {
              Lua = {
                diagnostics = {
                  enable = true,
                  globals = { "vim" },
                },
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          },
          pyright = {},
          yamlls = {
            settings = {
              yaml = {
                schemaStore = {
                  url = "https://www.schemastore.org/api/json/catalog.json",
                  enable = true,
                },
              },
            },
          },
          jsonls = {},
          gopls = {
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
            settings = {
              gopls = {
                completeUnimported = true,
                usePlaceholders = true,
                analyses = {
                  unusedparams = true,
                },
              },
            },
          },
          intelephense = {},
          laravel_ls = {
            filetypes = { "php", "blade" },
          },
        }

        for name, config in pairs(servers) do
          config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
          vim.lsp.config(name, config)
        end
      end

      -- Setup after mason-tool-installer completes
      vim.api.nvim_create_autocmd("User", {
        pattern = "MasonToolsInstallerCompleted",
        callback = function()
          setup_lsp_servers()
        end,
      })

      -- Also run immediately in case tools are already installed
      setup_lsp_servers()

      -- Buffer-local keymaps on LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local opts = { buffer = bufnr }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, opts)
          vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
          vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<A-n>", function()
            vim.diagnostic.jump({ count = 1 })
          end, opts)
          vim.keymap.set("n", "<A-p>", function()
            vim.diagnostic.jump({ count = -1 })
          end, opts)
          vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, opts)
        end,
      })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern",
        options = {
          show_all_diags_on_cursorline = true,
          use_icons_from_diagnostic = true,
          enable_on_select = true,
        },
      })
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
}
