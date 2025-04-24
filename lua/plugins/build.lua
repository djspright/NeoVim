return {
  {
    "Civitasv/cmake-tools.nvim",
    ft = { "c", "cpp", "cmake" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("cmake-tools").setup({
        cmake_command = "cmake",
        cmake_build_directory = "build",
        cmake_generate_options = { "-D", "CMAKE_EXPORT_COMPILE_COMMANDS=1" },
        cmake_build_options = {},
        cmake_console_size = 10,
        cmake_show_console = "always",
        cmake_dap_configuration = {
          name = "Launch file",
          type = "lldb",
          request = "launch",
          program = function()
            return "${workspaceFolder}/build/hello_world"
          end,
          args = {},
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          runInTerminal = false,
        },
      })
    end,
  },
}
