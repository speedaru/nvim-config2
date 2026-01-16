return { cmd = { 'clangd', "--header-insertion=never" },
  root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt' },
  filetypes = { 'c', 'cpp', 'h', 'hpp' },
  on_attach = function (client, bufnr)
      local signature_cfg = require("lsp_signature").setup()
      require("lsp_signature").on_attach(signature_cfg, bufnr)
  end,
}
