# Lua Conventions

Neovim configuration style guidelines.

## Formatting

Always run `stylua` before committing Lua files:

```bash
stylua path/to/file.lua
```

Formatting rules defined in `roles/neovim/files/.stylua.toml`.

## Naming

Use `snake_case` for variables and functions:

```lua
local my_variable = "value"
local function my_function() end
```

## Module Pattern

Use the `M` module table export pattern:

```lua
local M = {}

function M.setup()
    -- configuration
end

function M.some_method()
    -- method implementation
end

return M
```

Then use with `require('module_name')`.

## Function Design

- Keep functions small and focused
- Avoid side-effects at require time
- Pure functions are preferred

```lua
-- Good
local function format_text(text)
    return text:gsub('^%s+', ''):gsub('%s+$', '')
end

-- Avoid: side-effect at require time
local config = load_config()  -- runs at import
```

## Import Order

Order imports by scope:

1. Standard libraries (`vim`, `io`, etc.)
2. External plugins (`telescope`, `lspconfig`, etc.)
3. Local modules (`utils`, `helpers`, etc.)

```lua
-- Standard library
local vim = vim

-- External
local telescope = require('telescope')
local lsp = require('lspconfig')

-- Local
local utils = require('utils')
local mappings = require('mappings')
```

## Removing Unused

Remove unused imports and variables before committing:

```lua
-- Remove this if unused
local unused = require('unused_module')
```

## Options

Use `vim.opt` for buffer-local options:

```lua
vim.opt.number = true
vim.opt.expandtab = true
```

For filetype-specific options:

```lua
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'lua',
    callback = function()
        vim.opt_local.tabstop = 4
    end,
})
```

## Keymaps

Define keymaps with descriptive names:

```lua
vim.keymap.set('n', '<leader>ff', function()
    -- find files
end, { desc = 'Find files' })
```

## Neovim API

- Use `vim.api.nvim_*` for programmatic control
- Use `vim.opt` for options (not `set` directly)
- Use `vim.keymap.set` for mappings (not `nnoremap`)

## References

- `.stylua.toml`: `roles/neovim/files/.stylua.toml`
- Copilot prompts: `roles/neovim/files/copilot-prompts/`
