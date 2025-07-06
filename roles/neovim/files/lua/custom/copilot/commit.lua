local M = {}

local chat = require("CopilotChat")

local function load_prompt(path)
  local lines = vim.fn.readfile(vim.fn.expand(path))
  if vim.tbl_isempty(lines) then
    vim.notify("Prompt file is empty or not found: " .. path, vim.log.levels.ERROR)
    return nil
  end
  return table.concat(lines, "\n")
end

function M.CopilotGenerateCommit()
  local prompt_path = "~/.config/nvim/copilot-prompts/conventional-commit.md"
  local prompt = load_prompt(prompt_path)
  if not prompt then
    return
  end

  -- Get staged diff only
  local diff = vim.fn.system("git diff --cached")
  if diff == "" then
    vim.notify("No staged changes found. Please stage your changes first.", vim.log.levels.INFO)
    return
  end

  local final_prompt = prompt .. "\n" .. "```diff\n" .. diff .. "\n```"

  chat.open()
  chat.ask(final_prompt, {
    model = "gpt-4",
  })
end

function M.setup()
  vim.api.nvim_create_user_command("CopilotGenerateCommit", M.CopilotGenerateCommit, {})
end

return M
