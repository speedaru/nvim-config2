local jdtls = require("jdtls")

local function start()
  -- find project root (fallback to current folder if nothing found)
  local root_dir = require("jdtls.setup").find_root({
    ".git",
    "pom.xml",
    "build.gradle",
    "settings.gradle",
  }) or vim.fn.getcwd()

  -- print("Project root:", root_dir)

  -- Define workspace folder (needed by jdtls)
  local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

  -- Basic jdtls config
  local config = {
    cmd = { "jdtls" },  -- ensure jdtls is in PATH or use full Mason path
    root_dir = root_dir,
    workspace_dir = workspace_dir,
    settings = {
      java = {},  -- default settings, can extend
    },
    init_options = {
      bundles = {},
    },
  }

  -- Start or attach jdtls
  jdtls.start_or_attach(config)
end

return {
  start = start
}
