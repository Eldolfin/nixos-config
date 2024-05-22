-- Custom Parameters (with defaults)
return {
	"David-Kunz/gen.nvim",
	opts = {
		model = "mistral", -- The default model to use.
		display_mode = "float", -- The display mode. Can be "float" or "split".
		show_prompt = true, -- Shows the Prompt submitted to Ollama.
		show_model = true, -- Displays which model you are using at the beginning of your chat session.
		no_auto_close = true, -- Never closes the window automatically.
		init = function(options) end,
		-- Function to initialize Ollama
		command = "curl --silent --no-buffer -X POST http://192.168.21.70:11434/api/generate -d $body",
	},
}
