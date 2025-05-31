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
        automatic_enable = false,
        ensure_installed = {
          "lua_ls",
          "ts_ls",
          "html",
          "tailwindcss",
          "pyright",
          "volar",
          "cssls",
          "yamlls",
          "jsonls",
          "gopls",
          "dockerls",
          "docker_compose_language_service",
        },
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
          "biome"
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
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Dislay hover info" })
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "<leader>gr", require("telescope.builtin").lsp_references, { desc = "Go to references" })
      vim.keymap.set(
        "n",
        "<leader>ds",
        require("telescope.builtin").lsp_document_symbols,
        { desc = "Show documen symbols" }
      )
      vim.keymap.set(
        "n",
          "<leader>ws",
          require("telescope.builtin").lsp_dynamic_workspace_symbols,
          { desc = "Show workspace symbols" }
      )
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Show code actions" })
      vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({count=1})
      end, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({count=-1})
      end, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic" })

      -- Define sign icons for each severity
      local signs = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.HINT] = "󰠠 ",
        [vim.diagnostic.severity.INFO] = " ",
      }

      -- Set the diagnostic config with all icons
      vim.diagnostic.config({
        signs = {
          text = signs,
        },
        virtual_text = true,
        underline = true,
        update_in_insert = false,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig/util")
      require("neodev").setup()

      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
      })

      lspconfig.cssls.setup({
        capabilities = capabilities,
      })

      lspconfig.volar.setup({
        capabilities = capabilities,
        filetypes = { "vue", "javascript", "typescript", "javascriptreact", "typescriptreact" },
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.pyright.setup({
        capabilities = capabilities,
      })

      lspconfig.yamlls.setup({
        capabilities = capabilities,
        settings = {
          yaml = {
            schemaStore = {
              url = "https://www.schemastore.org/api/json/catalog.json",
              enable = true,
            },
          },
        },
      })

      lspconfig.jsonls.setup({
        capabilities = capabilities,
      })

      lspconfig.gopls.setup({
        capabilities = capabilities,
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        }
      })
    end,
  },
}
