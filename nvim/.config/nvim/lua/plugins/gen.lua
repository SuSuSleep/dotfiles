return {
  "David-Kunz/gen.nvim",
  keys = {
    { "<leader>ap", "<cmd>Gen<cr>", mode = { "n", "v" }, desc = "Open prompts" },
    { "<leader>ad", "<cmd>Gen Create_Docstrings<cr>", mode = { "v" }, desc = "Create docstrings" },
    { "<leader>ac", "<cmd>Gen Complete_Code<cr>", mode = { "v", "n" }, desc = "Complete code" },
    { "<leader>ae", "<cmd>Gen Explain_Code<cr>", mode = { "v" }, desc = "Explain code" },
  },
  opts = {
    model = "codellama:13b", -- The default model to use.
    quit_map = "q", -- set keymap to close the response window
    retry_map = "<c-r>", -- set keymap to re-send the current prompt
    accept_map = "<c-cr>", -- set keymap to replace the previous selection with the last result
    host = "192.168.50.94", -- The host running the Ollama service.
    port = "11434", -- The port on which the Ollama service is listening.
    display_mode = "float", -- The display mode. Can be "float" or "split" or "horizontal-split".
    show_prompt = false, -- Shows the prompt submitted to Ollama.
    show_model = false, -- Displays which model you are using at the beginning of your chat session.
    no_auto_close = false, -- Never closes the window automatically.
    file = false, -- Write the payload to a temporary file to keep the command short.
    hidden = false, -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
    -- Function to initialize Ollama
    command = function(options)
      local body = { model = options.model, stream = true }
      print(body)
      return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
    end,
    -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
    -- This can also be a command string.
    -- The executed command must return a JSON object with { response, context }
    -- (context property is optional).
    -- list_models = '<omitted lua function>', -- Retrieves a list of model names
    debug = true, -- Prints errors and the command which is run.
    prompts = {
      Create_Docstrings = {
        prompt = " The generated docstring should follow the rules of PEP 257. Provide a docstring based on the following code: $aregister. Only output the result in format ```$filetype\n...\n$text```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      },
      Complete_Code = {
        prompt = "Finish the following code based on the commnet and existed code: $text. Only output the result in format ```$filetype\n$text\n...\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      },
      Explain_Code = {
        prompt = "Provide a detailed explanation of the following code: $text. ",
        replace = false,
      },
    },
  },
}
