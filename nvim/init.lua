local config_root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")

package.path = table.concat({
	config_root .. "/lua/?.lua",
	config_root .. "/lua/?/init.lua",
	package.path,
}, ";")

require("config.options")
require("config.keymaps")
require("config.lazy")