local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Variable Assignment
  s("set", fmt("<#assign {} = {}>", {
    i(1, "varName"),
    i(2, "value"),
  })),

  -- Conditional (If)
  s("if", fmt([[
<#if {}>
  {}
</#if>
]], {
    i(1, "condition"),
    i(2, "body"),
  })),

  -- Conditional (If-Else)
  s("ife", fmt([[
<#if {}>
  {}
<#else>
  {}
</#if>
]], {
    i(1, "condition"),
    i(2, "body"),
    i(3, "else_body"),
  })),

  -- Loop (List Iteration)
  s("listloop", fmt([[
<#list {} as {}>
  {}
</#list>
]], {
    i(1, "list"),
    i(2, "item"),
    i(3, "body"),
  })),

  -- Macro Definition
  s("macro", fmt([[
<#macro {}>
  {}
</#macro>
]], {
    i(1, "macroName"),
    i(2, "body"),
  })),

  -- Include a File
  s("include", fmt([[<#include "{}">]], {
    i(1, "filename.ftl"),
  })),

  -- List Length
  s("len", fmt("${{{}?size}}", {
    i(1, "list"),
  })),

  -- Escape String
  s("escape", fmt("${{{}?html}}", {
    i(1, "string"),
  })),

  -- Comment Block
  s("comment", fmt("<#-- {} -->", {
    i(1, "Comment here"),
  })),

  -- Import a Template
  s("import", fmt([[<#import "{}" as {}>]], {
    i(1, "template.ftl"),
    i(2, "namespace"),
  })),
}

