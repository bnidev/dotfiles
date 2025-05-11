return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    -- Override eslint_d config for `nvim-lint`
    lint.linters.eslint_d = {
      cmd = vim.fn.stdpath("data") .. "/mason/bin/eslint_d", -- Path to eslint_d installed by Mason
      stdin = false, -- Don't use stdin (i.e., no live feedback)
      args = {}, -- Don't pass deprecated flags like --extensions or --useEslintrc
      stream = "stdout", -- Stream lint results to stdout
      ignore_exitcode = true, -- Ignore non-zero exit codes from eslint_d
      parser = require("lint.parser").from_errorformat("%f: line %l, col %c, %trror - %m", {
        source = "eslint_d",
        severity = vim.diagnostic.severity.ERROR, -- Set severity to error for ESLint issues
      }),
    }

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      python = { "pylint" },
      go = { "golangcilint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
