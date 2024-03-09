require("chatgpt").setup({
	popup_input= {
		submit = "<C-m>",
	},
})

UnitTests = function(gp, params)
    local template = "I have the following code from {{filename}}:\n\n"
        .. "```{{filetype}}\n{{selection}}\n```\n\n"
        .. "Please respond by writing table driven unit tests for the code above."
    gp.Prompt(params, gp.Target.enew, nil, gp.config.command_model,
        template, gp.config.command_system_prompt)
end
