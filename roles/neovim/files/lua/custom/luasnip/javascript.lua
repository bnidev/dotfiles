local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Console log
  s("clg", fmt("console.log({})", { i(1) })),

  -- Arrow Function
  s(
    "arrow",
    fmt(
      [[
const {} = ({}) => {{
  {}
}}
]],
      {
        i(1, "functionName"),
        i(2, "params"),
        i(3, "body"),
      }
    )
  ),

  -- Named Function Declaration
  s(
    "func",
    fmt(
      [[
function {}({}) {{
  {}
}}
]],
      {
        i(1, "functionName"),
        i(2, "params"),
        i(3, "body"),
      }
    )
  ),

  -- Anonymous Function
  s(
    "anon",
    fmt(
      [[
const {} = ({}) => {{
  {}
}}
]],
      {
        i(1, "functionName"),
        i(2, "params"),
        i(3, "body"),
      }
    )
  ),

  -- Async Arrow Function
  s(
    "async-arrow",
    fmt(
      [[
const {} = async ({}) => {{
  {}
}}
]],
      {
        i(1, "functionName"),
        i(2, "params"),
        i(3, "body"),
      }
    )
  ),

  -- Named Async Function
  s(
    "async-func",
    fmt(
      [[
async function {}({}) {{
  {}
}}
]],
      {
        i(1, "functionName"),
        i(2, "params"),
        i(3, "body"),
      }
    )
  ),

  -- Immediately Invoked Function Expression (IIFE)
  s(
    "iife",
    fmt(
      [[
(function({}) {{
  {}
}})({});
]],
      {
        i(1, "params"),
        i(2, "body"),
        i(3, "arguments"),
      }
    )
  ),
}
