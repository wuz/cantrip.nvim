return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "swift",
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "xcode-build-server",
        "swiftlint",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        swift = { "swiftlint", lsp_format = "first" },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          cmd = { "xcrun", "--toolchain", "swift", "sourcekit-lsp" },
          settings = {
            serverArguments = { "--log-level", "debug" },
            trace = { server = "messages" },
          },
          filetypes = { "swift", "c", "cpp", "objective-c", "objective-cpp", "objc", "objcpp" },
          root_markers = {
            "buildServer.json",
            "*.xcodeproj",
            "*.xcworkspace",
            "compile_commands.json",
            "Package.swift",
          },
          capabilities = {
            textDocument = {
              diagnostic = {
                dynamicRegistration = true,
                relatedDocumentSupport = true,
              },
            },
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
        },
      },
    },
  },
}
