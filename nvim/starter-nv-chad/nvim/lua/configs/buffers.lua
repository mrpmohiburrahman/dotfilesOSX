local M = {}

-- unwanted buffers after they go away
local UNWANTED_NAMES = {
  "^man://",
}

--- @enum buffers.Special
M.Special = {
  HELP = 1,
  QUICK_FIX = 2,
  MAN = 3,
  FUGITIVE = 4,
  NVIM_TREE = 5,
  DIR = 6,
  OTHER = 7,
}

--- &buftype is empty, name is empty, not modified
--- @param bufnr number
--- @return boolean
local function is_no_name_new(bufnr)
  if vim.bo[bufnr].buftype ~= "" then
    return false
  end

  return vim.api.nvim_buf_get_name(bufnr) == "" and not vim.bo[bufnr].modified
end

--- au WinClosed
--- wipe unwanted buffers by name
--- @param data table
function M.wipe_unwanted(data)
  local name = vim.api.nvim_buf_get_name(data.buf)

  for _, s in ipairs(UNWANTED_NAMES) do
    if name:find(s) then
      vim.cmd.bwipeout(data.buf)
      return
    end
  end
end

--- au BufEnter
--- wipe # when it's a no-name new not visible anywhere
--- @param data table
function M.wipe_alt_no_name_new(data)
  local bufnr_alt = vim.fn.bufnr("#")
  local winnr_alt = vim.fn.bufwinnr(bufnr_alt)

  -- alt is not visible
  if bufnr_alt ~= -1 and data.buf ~= bufnr_alt and winnr_alt == -1 and is_no_name_new(bufnr_alt) then
    vim.cmd.bwipeout(bufnr_alt)
  end
end

--- au BufLeave
--- au FocusLost
--- autowriteall doesn't cover all cases
--- @param data table
function M.update(data)
  local bo = vim.bo[data.buf]
  if bo and bo.buftype == "" and not bo.readonly and bo.modifiable and vim.api.nvim_buf_get_name(data.buf) ~= "" then
    vim.cmd.update()
  end
end

--- &buftype set or otherwise not a normal buffer
--- @param bufnr number
--- @return buffers.Special|nil
function M.special(bufnr)
  local buftype = vim.bo[bufnr].buftype
  local bufhidden = vim.bo[bufnr].bufhidden

  -- scratch is not special
  if buftype == "nofile" and bufhidden == "hide" then
    return nil
  end

  local filetype = vim.bo[bufnr].filetype
  local bufname = vim.api.nvim_buf_get_name(bufnr)

  if buftype == "help" then
    return M.Special.HELP
  elseif buftype == "quickfix" then
    return M.Special.QUICK_FIX
  elseif filetype == "man" then
    return M.Special.MAN
  elseif filetype:match("^fugitive") then
    return M.Special.FUGITIVE
  elseif filetype == "NvimTree" then
    return M.Special.NVIM_TREE
  elseif vim.fn.isdirectory(bufname) ~= 0 then
    return M.Special.DIR
  elseif buftype ~= "" then
    return M.Special.OTHER
  end

  return nil
end

--- Wipe all buffers but the current
function M.wipe_all()
  local cur = vim.api.nvim_get_current_buf()

  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if buf ~= cur then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

--- :setlocal list/nolist
function M.toggle_list()
  local list = vim.api.nvim_get_option_value("list", { scope = "local" })
  vim.api.nvim_set_option_value("list", not list, { scope = "local" })
end

---@type table<number, boolean>
local buf_list_trailing = {}

--- toggle TrailingSpace and list for buffer
function M.toggle_whitespace()
  local buf = vim.api.nvim_get_current_buf()

  if buf_list_trailing[buf] then
    vim.api.nvim_set_option_value("list", false, { scope = "local" })
    pcall(vim.fn.matchdelete, buf_list_trailing[buf])
    buf_list_trailing[buf] = nil
  else
    vim.api.nvim_set_option_value("list", true, { scope = "local" })
    vim.fn.matchadd("TrailingSpace", "\\s\\+$")
    buf_list_trailing[buf] = true
  end
end

--- clear list_trailing_buf
function M.purge_whitespace_data(data)
  buf_list_trailing[data.buf] = nil
end

--- clear trailing whitespace and last searched
function M.trim_whitespace()
  vim.cmd("%s/\\s\\+$//e")
  vim.fn.setreg("/", "")
end

--- write to a new scratch buffer
--- @param text string newline delimited
function M.write_scratch(text)
  local bufnr = vim.api.nvim_create_buf(true, true)

  local line = 0
  if text then
    for s in text:gmatch("[^\r\n]+") do
      vim.fn.appendbufline(bufnr, line, s)
      line = line + 1
    end
  end

  vim.cmd.buffer(bufnr)
end

return M
