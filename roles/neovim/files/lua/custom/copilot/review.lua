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

-- Run the review based on diff command and prompt
local function review(diff_cmd, prompt_path, no_changes_msg)
  local prompt = load_prompt(prompt_path)
  if not prompt then
    return
  end

  -- For merge review update origin before diff
  if diff_cmd:find("origin/") then
    vim.fn.system("git fetch origin")
  end

  local diff = vim.fn.system(diff_cmd)
  if diff == "" then
    vim.notify(no_changes_msg, vim.log.levels.INFO)
    return
  end

  local final_prompt = prompt .. "\n" .. "```diff\n" .. diff .. "\n```"
  chat.open()
  chat.ask(final_prompt, { model = "gpt-4" })
end

function M.CopilotReviewUnstaged()
  review("git diff", "~/.config/nvim/copilot-prompts/review-unstaged-files.md", "No unstaged changes to review.")
end

function M.CopilotReviewStaged()
  review("git diff --cached", "~/.config/nvim/copilot-prompts/review-staged-files.md", "No staged changes to review.")
end

function M.CopilotReviewMerge()
  -- Get the default branch name
  local default_branch =
    vim.fn.system("git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'"):gsub("%s+", "")
  if default_branch == "" then
    vim.notify("Could not determine the default branch.", vim.log.levels.ERROR)
    return
  end

  review(
    string.format("git diff origin/%s...HEAD", default_branch),
    "~/.config/nvim/copilot-prompts/review-merge-request.md",
    "No changes to review in merge request."
  )
end

function M.setup()
  vim.api.nvim_create_user_command("CopilotReviewUnstaged", M.CopilotReviewUnstaged, {})
  vim.api.nvim_create_user_command("CopilotReviewStaged", M.CopilotReviewStaged, {})
  vim.api.nvim_create_user_command("CopilotReviewMerge", M.CopilotReviewMerge, {})
end

return M
