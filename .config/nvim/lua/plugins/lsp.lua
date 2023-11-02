return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        solargraph = {
          mason = false,
          cmd = { "bundle", "exec", "solargraph", "stdio" },
          flags = {
            debounce_text_changes = 150,
          },
          solargraph = {
            diagnostics = true,
          },
        },
        elixirls = {
          mason = false,
          settings = {
            elixirLS = {
              dialyzerEnabled = false,
            },
          },
          cmd = { "/Users/joechiarella/.lsp/elixir-ls/language_server.sh" },
        },
      },
    },
  },
}
