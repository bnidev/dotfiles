local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Vue Single File Component with script setup, template, and style
  s("vue", fmt([[
<script setup lang="ts">
  {}
</script>

<template>
  {}
</template>

<style scoped>
  {}
</style>
]], {
    i(1, "script setup content"),
    i(2, "template content"),
    i(3, "styles here"),
  })),

  -- Vue Component: Props
  s("prop", fmt([[
props: {{
  {}
}}
]], {
    i(1, "myProp: String"),
  })),

  -- Vue Component: Ref Usage
  s("ref", fmt([[
const {} = ref({});
]], {
    i(1, "myRef"),
    i(2, "initialValue"),
  })),

  -- Vue Component: Computed Property
  s("computed", fmt([[
const {} = computed(() => {});
]], {
    i(1, "computedValue"),
    i(2, "someLogic"),
  })),

  -- Vue Component: Watcher
  s("watch", fmt([[
watch({}, () => {});
]], {
    i(1, "watchedValue"),
    i(2, "watchLogic"),
  })),

  -- Vue Component: v-for
  s("vfor", fmt([[
<template>
  <div v-for="{} in {}" :key="{}">
    {}
  </div>
</template>
]], {
    i(1, "item"),
    i(2, "itemsArray"),
    i(3, "item.id"),
    i(4, "item content"),
  })),
}

