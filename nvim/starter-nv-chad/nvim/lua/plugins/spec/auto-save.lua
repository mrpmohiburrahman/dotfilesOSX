return {{
    "okuuva/auto-save.nvim",
    cmd = "ASToggle", -- optional for lazy loading on command
    event = {"InsertLeave", "TextChanged"}, -- optional for lazy loading on trigger events
    opts = {
        enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
        execution_message = {
            enabled = false,
            message = function() -- message to print on save
                local msg = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")
                -- vim.notify(msg, "info", {
                --     title = "AutoSave",
                --     timeout = 500, -- Adjust the timeout as needed for minimalistic display
                --     icon = "🛠" -- Optional: Add an icon to make it visually distinct
                -- })
                return msg
            end,
            dim = 0.18, -- dim the color of `message`
            cleaning_interval = 1250 -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
        },
        trigger_events = { -- See :h events
            immediate_save = {"BufLeave", "FocusLost"}, -- vim events that trigger an immediate save
            defer_save = {"InsertLeave", "TextChanged", "TextChangedI"}, -- vim events that trigger a deferred save (saves after `debounce_delay`)
            cancel_defered_save = {"InsertEnter"} -- vim events that cancel a pending deferred save
        },
        -- function that takes the buffer handle and determines whether to save the current buffer or not
        -- return true: if buffer is ok to be saved
        -- return false: if it's not ok to be saved
        -- if set to `nil` then no specific condition is applied
        condition = nil,
        write_all_buffers = false, -- write all buffers when the current one meets `condition`
        noautocmd = false, -- Do not execute autocmds when saving
        lockmarks = false, -- lock marks when saving, see `:h lockmarks` for more details
        debounce_delay = 1000, -- delay after which a pending save is executed (default 1000)
        debug = false
    }
}}
