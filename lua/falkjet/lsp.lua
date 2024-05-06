local lspformat = require 'lsp-format'
local telescope_builtin = require 'telescope.builtin'
local neodev = require 'neodev'


local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  emmet_ls = {
    filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact',
      'typescriptreact', 'svelte', 'gohtmltmpl', 'htmldjango', 'vue',
      'templ', 'astro', 'php', 'css', 'xml', 'razor'
    }
  },
  hls = {
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
    cmd = { "haskell-language-server-wrapper", "--lsp" },
  },
  clangd = {
    filetypes = { 'c', 'cpp', 'objcpp', 'cuda' },
  },
  ocamllsp = {},
  zls = {},
  gopls = {},
  nil_ls = {},
  rust_analyzer = {},
  pylsp = {},
  psalm = {},
  intelephense = {},
  roc_language_server = {},
  denols = {},
  tsserver = {},
  svelte = {},
  jsonls = {},
  templ = {},
}

require 'lspconfig.configs'.roc_language_server = {
  default_config = {
    single_file_support = true,
    cmd = { 'roc_language_server' },
    filetypes = { 'roc' },
    root_dir = require 'lspconfig'.util.find_git_ancestor,
    settings = {},
  }
}

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end
})

local on_attach = function(client, bufnr)
  lspformat.on_attach(client)

  local nmap = function(keys, func, desc)
    if desc then desc = 'LSP: ' .. desc end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')

  nmap('gd', telescope_builtin.lsp_definitions, '[G]oto [D]efinition')
  nmap('gt', telescope_builtin.lsp_type_definitions, '[G]oto [D]efinition')
  nmap('gr', telescope_builtin.lsp_references, '[G]oto [R]eferences')
  nmap('gI', telescope_builtin.lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', telescope_builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', telescope_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:LspFormat` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Disable virtual text
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false
  }
)

neodev.setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)

for server_name, config in pairs(servers) do
  require 'lspconfig'[server_name].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = servers[server_name],
    filetypes = (servers[server_name] or {}).filetypes
  }
end

-- vim: ts=2 sts=2 sw=2 et
