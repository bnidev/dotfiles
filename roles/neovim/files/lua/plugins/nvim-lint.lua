return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    -- Cache table for root dirs and biome.json presence
    local cache = {}

    -- Check for biome.json presence upward from buffer root, with caching
    local function has_biome_config(bufnr)
      local filename = vim.api.nvim_buf_get_name(bufnr)
      if filename == "" then
        return false
      end
      local root = vim.fs.dirname(filename)

      if cache[root] ~= nil then
        return cache[root]
      end

      local found = vim.fs.find({ "biome.json" }, { upward = true, path = root, type = "file" })
      local has_biome = (#found > 0)
      cache[root] = has_biome
      return has_biome
    end

    -- Notify once per buffer about linter choice
    local function notify_once(bufnr, message, level)
      if not vim.b[bufnr].lint_notified then
        vim.notify(message, level, { title = "nvim-lint" })
        vim.b[bufnr].lint_notified = true
      end
    end

    -- Override eslint_d config for `nvim-lint`
    lint.linters.eslint_d = {
      name = "eslint_d",
      cmd = vim.fn.stdpath("data") .. "/mason/bin/eslint_d",
      stdin = false,
      args = {},
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.parser").from_errorformat("%f: line %l, col %c, %trror - %m", {
        source = "eslint_d",
        severity = vim.diagnostic.severity.ERROR,
      }),
    }

    local biome_filetypes = {
      javascript = true,
      typescript = true,
      javascriptreact = true,
      typescriptreact = true,
      vue = true,
    }

    lint.linters_by_ft = {
      python = { "pylint" },
      go = { "golangcilint" },
      css = { "biomejs" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("nvim_lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

        if biome_filetypes[ft] then
          local use_biome = has_biome_config(bufnr)
          if use_biome then
            lint.linters_by_ft.javascript = { "biomejs" }
            lint.linters_by_ft.typescript = { "biomejs" }
            lint.linters_by_ft.javascriptreact = { "biomejs" }
            lint.linters_by_ft.typescriptreact = { "biomejs" }
            lint.linters_by_ft.vue = { "biomejs" }
            notify_once(bufnr, "Using biome linter", vim.log.levels.INFO)
          else
            lint.linters_by_ft.javascript = { "eslint_d" }
            lint.linters_by_ft.typescript = { "eslint_d" }
            lint.linters_by_ft.javascriptreact = { "eslint_d" }
            lint.linters_by_ft.typescriptreact = { "eslint_d" }
            lint.linters_by_ft.vue = { "eslint_d" }
            notify_once(bufnr, "Using eslint_d linter", vim.log.levels.INFO)
          end
        end

        lint.try_lint()
      end,
    })
  end,
}
