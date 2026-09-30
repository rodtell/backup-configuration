return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- C & C++
    vim.lsp.config("clangd", {
      cmd = { "clangd" },
      filetypes = { "c", "cpp" },
      root_markers = { "compile_flags.txt" },
    })
    vim.lsp.enable("clangd")
    -- RUST
    vim.lsp.config("rust-analyzer", {
      cmd = { "rust-analyzer" },
      filetypes = { "rust" },
    })
    vim.lsp.enable("rust-analyzer")
    -- PYTHON
    vim.lsp.config("basedpyright", {
      cmd = { "basedpyright-langserver", "--stdio" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml" },
    })
    vim.lsp.enable("basedpyright")
    -- RUFF (PYTHON)
    vim.lsp.config("ruff", {
      cmd = { "ruff", "server" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml" },
    })
    vim.lsp.enable("ruff")
    -- JAVASCRIPT, TYPESCRIPT, JSX, TSX
    vim.lsp.config("Vtsls", {
      cmd = { "vtsls", "--stdio" },
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      root_markers = { "jsconfig.json", "tsconfig.json" },
      init_options = { hostInfo = "neovim" },
    })
    vim.lsp.enable("vtsls")
    -- OXLINT (JAVASCRIPT, TYPESCRIPT, JSX, TSX)
    vim.lsp.config("oxlint", {
      cmd = { "oxlint", "--lsp" },
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
    })
    vim.lsp.enable("oxlint")

    -- HTML
    vim.lsp.config("html", {
      cmd = { "vscode-html-language-server", "--stdio" },
      filetypes = { "html" },
      init_options = { provideFormatter = false },
    })
    vim.lsp.enable("html")
    -- CSS
    vim.lsp.config("cssls", {
      cmd = { "vscode-css-language-server", "--stdio" },
      filetypes = { "css", "scss", "less", "sass" },
      init_options = { provideFormatter = false },
      settings = {
        css = { validate = true },
        scss = { validate = true },
        less = { validate = true },
        sass = { validate = true },
      },
    })
    vim.lsp.enable("cssls")
    -- JSON
    vim.lsp.config("jsonls", {
      cmd = { "vscode-json-language-server", "--stdio" },
      filetypes = { "json", "jsonc" },
      init_options = { provideFormatter = false },
    })
    vim.lsp.enable("jsonls")
    -- YAML
    vim.lsp.config("yamlls", {
      cmd = { "yaml-language-server", "--stdio" },
      filetypes = { "yml", "yaml" },
      settings = { yaml = { format = { enable = true } } },
    })
    vim.lsp.enable("yamlls")
    -- TOML
    vim.lsp.config("taplo", {
      cmd = { "taplo", "lsp", "stdio" },
      filetypes = { "toml" },
      root_markers = { "." },
    })
    vim.lsp.enable("taplo")
    -- EMMET
    vim.lsp.config("emmet-language-server", {
      cmd = { "emmet-language-server", "--stdio" },
      filetypes = { "html", "css", "scss", "less", "sass" },
    })
    vim.lsp.enable("emmet-language-server")

    -- LSP GENERAL CONFIGURATION
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("GlobalLspConfig", { clear = true }),
      callback = function(event)
        local opts = { buffer = event.buf, silent = true }
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.semanticTokensProvider then
          client.server_capabilities.semanticTokensProvider =
            vim.tbl_deep_extend("force", client.server_capabilities.semanticTokensProvider, {})
        end

        -- KEYMAP
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      end,
    })
  end,
}
