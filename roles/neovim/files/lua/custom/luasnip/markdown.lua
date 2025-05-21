local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Inline Code
ls.add_snippets('markdown', {
  s({ trig = 'code' }, fmt('`{}`', { i(1, 'value') }))
})

-- Code Block
ls.add_snippets('markdown', {
  s({ trig = 'codeblock' }, fmt('```{}\n{}\n```', { i(1, 'value'), i(2, 'value') }))
})

-- Todo
ls.add_snippets('markdown', {
  s({ trig = 'td' }, fmt('- [{}]', { i(1, 'value') }))
})

-- Link
ls.add_snippets('markdown', {
  s({ trig = 'link' }, fmt('[{}]({})', { i(1, 'value'),  i(2, 'value')  }))
})
