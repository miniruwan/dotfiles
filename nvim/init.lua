local config_file = debug.getinfo(1, "S").source:sub(2)
local config_root = vim.fn.fnamemodify(vim.uv.fs_realpath(config_file) or config_file, ":p:h")

package.path = table.concat({
	config_root .. "/lua/?.lua",
	config_root .. "/lua/?/init.lua",
	package.path,
}, ";")

require("config.options")
require("config.keymaps")
require("config.lazy")