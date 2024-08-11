local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- local utils = require "gale.utils"
-- local buf_map = utils.buf_map
autocmd("VimEnter", {
    callback = function()
        local api = require "nvim-tree.api"
        api.tree.open()
    end
})

-- Autocommand group for auto-formatting using conform.nvim
autocmd("BufWritePre", {
    callback = function(args)
        local bufnr = args.buf
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
        end
        local conform = require("conform")
        conform.format {
            bufnr = bufnr,
            lsp_fallback = true
        }
    end,
    desc = "Automatically format on buffer write"
})

-- unwanted buffers after they go away
local UNWANTED_NAMES = {"^man://"}

--- @enum buffers.Special
Special = {
    HELP = 1,
    QUICK_FIX = 2,
    MAN = 3,
    FUGITIVE = 4,
    NVIM_TREE = 5,
    DIR = 6,
    OTHER = 7
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
function wipe_unwanted(data)
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
function wipe_alt_no_name_new(data)
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
function update(data)
    local bo = vim.bo[data.buf]
    if bo and bo.buftype == "" and not bo.readonly and bo.modifiable and vim.api.nvim_buf_get_name(data.buf) ~= "" then
        vim.cmd.update()
    end
end

--- &buftype set or otherwise not a normal buffer
--- @param bufnr number
--- @return buffers.Special|nil
function special(bufnr)
    local buftype = vim.bo[bufnr].buftype
    local bufhidden = vim.bo[bufnr].bufhidden

    -- scratch is not special
    if buftype == "nofile" and bufhidden == "hide" then
        return nil
    end

    local filetype = vim.bo[bufnr].filetype
    local bufname = vim.api.nvim_buf_get_name(bufnr)

    if buftype == "help" then
        return Special.HELP
    elseif buftype == "quickfix" then
        return Special.QUICK_FIX
    elseif filetype == "man" then
        return Special.MAN
    elseif filetype:match("^fugitive") then
        return Special.FUGITIVE
    elseif filetype == "NvimTree" then
        return Special.NVIM_TREE
    elseif vim.fn.isdirectory(bufname) ~= 0 then
        return Special.DIR
    elseif buftype ~= "" then
        return Special.OTHER
    end

    return nil
end

--- Wipe all buffers but the current
function wipe_all()
    local cur = vim.api.nvim_get_current_buf()

    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
        if buf ~= cur then
            vim.api.nvim_buf_delete(buf, {
                force = true
            })
        end
    end
end

--- :setlocal list/nolist
function toggle_list()
    local list = vim.api.nvim_get_option_value("list", {
        scope = "local"
    })
    vim.api.nvim_set_option_value("list", not list, {
        scope = "local"
    })
end

---@type table<number, boolean>
local buf_list_trailing = {}

--- toggle TrailingSpace and list for buffer
function toggle_whitespace()
    local buf = vim.api.nvim_get_current_buf()

    if buf_list_trailing[buf] then
        vim.api.nvim_set_option_value("list", false, {
            scope = "local"
        })
        pcall(vim.fn.matchdelete, buf_list_trailing[buf])
        buf_list_trailing[buf] = nil
    else
        vim.api.nvim_set_option_value("list", true, {
            scope = "local"
        })
        vim.fn.matchadd("TrailingSpace", "\\s\\+$")
        buf_list_trailing[buf] = true
    end
end

--- clear list_trailing_buf
function purge_whitespace_data(data)
    buf_list_trailing[data.buf] = nil
end

--- clear trailing whitespace and last searched
function trim_whitespace()
    vim.cmd("%s/\\s\\+$//e")
    vim.fn.setreg("/", "")
end

--- write to a new scratch buffer
--- @param text string newline delimited
function write_scratch(text)
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

local function au(event, callback, opts)
    if callback then
        vim.api.nvim_create_autocmd(event, vim.tbl_extend("force", {
            group = group,
            callback = callback
        }, opts or {}))
    end
end
au({"BufEnter"}, wipe_alt_no_name_new, {})
au({"BufDelete", "BufWipeout"}, purge_whitespace_data, {})
au({"WinClosed"}, wipe_unwanted, {})
au({"BufLeave", "FocusLost"}, update, {
    nested = true
})


-- Handle buffer deletion with bufdelete.nvim
-- autocmd("BufDelete", {
--     callback = function(event)
--         local buf = vim.fn.bufnr()
--         if vim.fn.buflisted(buf) == 0 then
--             require('bufdelete').bufdelete(buf, true) -- Use bufdelete.nvim to delete the buffer
--             vim.cmd("enew") -- Create a new empty buffer
--         end
--     end
-- })

-- autocmd("BufLeave", {
--   desc = "Hide tabufline if only one buffer and one tab are open.",
--   pattern = "*",
--   group = augroup("TabuflineHide", { clear = true }),
--   callback = function()
--     vim.schedule(function()
--       if #vim.t.bufs <= 1 and #vim.api.nvim_list_tabpages() <= 1 then
--         vim.o.showtabline = 0
--       else
--         vim.o.showtabline = 2
--       end
--     end)
--   end,
-- })

-- autocmd("Filetype", {
--   desc = "Prevent <Tab>/<S-Tab> from switching specific buffers.",
--   pattern = {
--     "codecompanion",
--     "lazy",
--     "qf",
--   },
--   group = augroup("PreventBufferSwap", { clear = true }),
--   callback = function(event)
--     local lhs_list = { "<Tab>", "<S-Tab>" }
--     buf_map(event.buf, "n", lhs_list, "<nop>")
--   end,
-- })

-- autocmd("FileType", {
--   desc = "Workaround for NvCheatsheet's zindex being higher than Mason's.",
--   pattern = "nvcheatsheet",
--   group = augroup("FixCheatsheetZindex", { clear = true }),
--   callback = function()
--     vim.api.nvim_win_set_config(0, { zindex = 44 })
--   end,
-- })

-- autocmd({ "BufEnter", "FileType" }, {
--   desc = "Prevent auto-comment on new line.",
--   pattern = "*",
--   group = augroup("NoNewLineComment", { clear = true }),
--   command = [[
--     setlocal formatoptions-=c formatoptions-=r formatoptions-=o
--   ]],
-- })

-- autocmd({ "BufNewFile", "BufRead" }, {
--   desc = "Add support for .mdx files.",
--   pattern = { "*.mdx" },
--   group = augroup("MdxSupport", { clear = true }),
--   callback = function()
--     vim.api.nvim_set_option_value("filetype", "markdown", { scope = "local" })
--   end,
-- })

-- autocmd("VimResized", {
--   desc = "Auto resize panes when resizing nvim window.",
--   pattern = "*",
--   group = augroup("VimAutoResize", { clear = true }),
--   command = [[ tabdo wincmd = ]],
-- })

-- autocmd("VimLeavePre", {
--   desc = "Close NvimTree before quitting nvim.",
--   pattern = "*",
--   group = augroup("NvimTreeCloseOnExit", { clear = true }),
--   callback = function()
--     if vim.bo.filetype == "NvimTree" then
--       vim.api.nvim_buf_delete(0, { force = true })
--     end
--   end,
-- })

-- autocmd("TextYankPost", {
--   desc = "Highlight on yank.",
--   group = augroup("HighlightOnYank", { clear = true }),
--   callback = function()
--     vim.highlight.on_yank { higroup = "YankVisual", timeout = 200, on_visual = true }
--   end,
-- })

-- autocmd("ModeChanged", {
--   desc = "Strategically disable diagnostics to focus on editing tasks.",
--   pattern = { "n:i", "n:v", "i:v" },
--   group = augroup("UserDiagnostic", { clear = true }),
--   callback = function()
--     vim.diagnostic.enable(false)
--   end,
-- })

-- autocmd({ "BufRead", "BufNewFile" }, {
--   desc = "Disable diagnostics in node_modules.",
--   pattern = "*/node_modules/*",
--   group = augroup("UserDiagnostic", { clear = true }),
--   callback = function()
--     vim.diagnostic.enable(false)
--   end,
-- })

-- autocmd("ModeChanged", {
--   desc = "Enable diagnostics upon exiting insert mode to resume feedback.",
--   pattern = "i:n",
--   group = augroup("UserDiagnostic", { clear = true }),
--   callback = function()
--     vim.diagnostic.enable(true)
--   end,
-- })

-- autocmd("BufWritePre", {
--   desc = "Remove trailing whitespaces on save.",
--   group = augroup("TrimWhitespaceOnSave", { clear = true }),
--   command = [[ %s/\s\+$//e ]],
-- })

-- autocmd("FileType", {
--   desc = "Define windows to close with 'q'",
--   pattern = {
--     "empty",
--     "help",
--     "startuptime",
--     "qf",
--     "query",
--     "lspinfo",
--     "man",
--     "checkhealth",
--     "nvcheatsheet",
--     "codecompanion",
--   },
--   group = augroup("WinCloseOnQDefinition", { clear = true }),
--   command = [[
--     nnoremap <buffer><silent> q :close<CR>
--     set nobuflisted
--   ]],
-- })

-- autocmd("BufHidden", {
--   desc = "Delete [No Name] buffers.",
--   group = augroup("DeleteNoNameBuffer", { clear = true }),
--   callback = function(event)
--     if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
--       vim.schedule(function()
--         pcall(vim.api.nvim_buf_delete, event.buf, {})
--       end)
--     end
--   end,
-- })

-- autocmd("ModeChanged", {
--   -- https://github.com/L3MON4D3/LuaSnip/issues/258
--   desc = "Prevent weird snippet jumping behavior.",
--   pattern = { "s:n", "i:*" },
--   group = augroup("PreventSnippetJump", { clear = true }),
--   callback = function()
--     local ls = require "luasnip"
--     local bufnr = vim.api.nvim_get_current_buf()

--     if ls.session.current_nodes[bufnr] and not ls.session.jump_active then
--       ls.unlink_current()
--     end
--   end,
-- })

-- -- https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
-- -- https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
-- autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
--   desc = "Automatically update changed file in nvim.",
--   group = augroup("AutoupdateOnFileChange", { clear = true }),
--   command = [[
--     silent! if mode() != 'c' && !bufexists("[Command Line]") | checktime | endif
--   ]],
-- })

-- -- https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
-- autocmd("FileChangedShellPost", {
--   desc = "Show notification on file change.",
--   group = augroup("NotifyOnFileChange", { clear = true }),
--   command = [[
--     echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
--   ]],
-- })

-- autocmd("User", {
--   desc = "Enable line number in Telescope preview.",
--   pattern = "TelescopePreviewerLoaded",
--   group = augroup("CustomTelescopePreview", { clear = true }),
--   callback = function()
--     vim.opt_local.number = true
--   end,
-- })

-- autocmd("TermOpen", {
--   desc = "Prevent left click on terminal buffers from exiting insert mode.",
--   pattern = "*",
--   group = augroup("LeftMouseClickTerm", { clear = true }),
--   callback = function(event)
--     local mouse_actions = {
--       "<LeftMouse>",
--       "<2-LeftMouse>",
--       "<3-LeftMouse>",
--       "<4-LeftMouse>",
--     }
--     buf_map(event.buf, "t", mouse_actions, "<nop>")
--   end,
-- })
