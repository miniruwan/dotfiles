local map = vim.keymap.set

local function open_url(url)
  if vim.fn.has("wsl") == 1 then
    local chrome = "/mnt/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"
    if vim.fn.executable(chrome) == 1 then
      vim.fn.jobstart({ chrome, url }, { detach = true })
      return
    end
  end

  if vim.fn.has("mac") == 1 then
    vim.fn.jobstart({ "open", "-a", "Google Chrome", url }, { detach = true })
  else
    vim.fn.jobstart({ "xdg-open", url }, { detach = true })
  end
end

local function search_selection()
  local previous_register = vim.fn.getreg("z")
  local previous_type = vim.fn.getregtype("z")
  vim.cmd([[normal! "zy]])
  local text = vim.fn.getreg("z")
  vim.fn.setreg("z", previous_register, previous_type)

  text = text:gsub("^%s+", ""):gsub("%s+$", "")
  if text == "" then
    return
  end

  local encoded = vim.uri_encode and vim.uri_encode(text) or text:gsub("%s+", "+")
  open_url("https://www.google.com/search?q=" .. encoded)
end

map("v", "<C-c>", '"+y', { desc = "Copy selection" })
map("v", "<C-x>", '"+d', { desc = "Cut selection" })
map("v", "??", search_selection, { desc = "Search selection on the web" })

map("n", "<ScrollWheelUp>", "<C-y>", { desc = "Scroll up" })
map("n", "<ScrollWheelDown>", "<C-e>", { desc = "Scroll down" })
map("n", "<leader>h", ":%s/<C-r><C-w>/", { desc = "Replace word under cursor" })
map("n", "<leader>w", "<C-w>w", { desc = "Next window" })
map("i", "<C-\\>", "<Esc>A", { desc = "Move after closing pair" })
map("n", "<leader>et", ":tabe ~/temp/temp.txt<CR>", { desc = "Open temp file" })

vim.api.nvim_create_user_command("VT", "tabe ~/temp/temp.txt", {})