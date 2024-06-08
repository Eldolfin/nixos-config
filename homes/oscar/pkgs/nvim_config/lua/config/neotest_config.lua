require("neotest").setup({
	adapters = {
		require("neotest-python")({
			-- Command line arguments for runner
			-- Can also be a function to return dynamic values
			args = { "-n", "12", "--timeout", "3", "--tb=short" },
			pytest_discover_instances = true,
		}),
	},
})
