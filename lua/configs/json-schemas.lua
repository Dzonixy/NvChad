local M = {}

function M.schemas()
  -- Common JSON schemas for autocompletion in config files
  return {
    {
      fileMatch = { "package.json" },
      url = "https://json.schemastore.org/package.json",
    },
    {
      fileMatch = { "tsconfig*.json" },
      url = "https://json.schemastore.org/tsconfig.json",
    },
    {
      fileMatch = { ".eslintrc", ".eslintrc.json" },
      url = "https://json.schemastore.org/eslintrc.json",
    },
    {
      fileMatch = { ".prettierrc", ".prettierrc.json" },
      url = "https://json.schemastore.org/prettierrc.json",
    },
    {
      fileMatch = { "deno.json", "deno.jsonc" },
      url = "https://deno.land/x/deno/cli/schemas/config-file.v1.json",
    },
    {
      fileMatch = { ".github/workflows/*.yml", ".github/workflows/*.yaml" },
      url = "https://json.schemastore.org/github-workflow.json",
    },
  }
end

return M
