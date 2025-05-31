return {
  "stevearc/conform.nvim",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local conform = require("conform")

    local function biome_formatter_enabled(ctx)
      -- Check if biome.json config is present
      local biome_config_path = vim.fs.find("biome.json", {
        upward = true,
        path = vim.fs.dirname(ctx.filename),
        type = "file",
      })[1]

      if not biome_config_path then
        -- no biome.json means disable formatter by default
        vim.notify("No biome.json found, using fallback if available", vim.log.levels.INFO)
        return false
      end

      local content = vim.fn.readfile(biome_config_path)
      local ok, parsed = pcall(vim.json.decode, table.concat(content, "\n"))
      if not ok then
        vim.notify("Failed to parse biome.json, using fallback if available", vim.log.levels.WARN)
        return false -- if parse failed, assume disabled
      end

      -- Check biome.json config if the formatter is disabled
      if parsed.formatter and parsed.formatter.enabled == false then
        vim.notify("Biome formatter disabled in biome.json, using fallback if available", vim.log.levels.INFO)
        return false
      end

      return true
    end

    conform.formatters.biome = {
      command = "biome",
      args = {
        "check",
        "--formatter-enabled=true",
        "--organize-imports-enabled=true",
        "--linter-enabled=false",
        "--write",
        "--stdin-file-path",
        "$FILENAME",
      },
      stdin = true,
      condition = biome_formatter_enabled,
    }

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "biome", "pretter", stop_after_first = true },
        typescript = { "biome", "prettier", stop_after_first = true },
        javascriptreact = { "biome", "prettier", stop_after_first = true },
        typescriptreact = { "biome", "prettier", stop_after_first = true },
        json = { "biome", "prettier", stop_after_first = true },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "biome", "prettier", stop_after_first = true },
        scss = { "prettier" },
        markdown = { "prettier" },
        php = { "prettier" },
        vue = { "prettier" },
        python = { "isort", "black" },
        go = { "goimports", "gofumpt" },
      },
    })

    vim.keymap.set("n", "<leader>ff", function()
      local filename = vim.api.nvim_buf_get_name(0)
      local shortname = filename ~= "" and vim.fn.fnamemodify(filename, ":t") or "[No file]"
      conform.format({
        lsp_fallback = true,
        async = true,
        timeout_ms = 500,
      })
      vim.notify("Formatting triggered for: " .. shortname, vim.log.levels.INFO)
    end, { desc = "Format file or range (visual mode)" })
  end,
}
