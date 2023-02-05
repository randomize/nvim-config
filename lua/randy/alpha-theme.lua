local if_nil = vim.F.if_nil

local default_terminal = {
    type = "terminal",
    command = nil,
    width = 69,
    height = 8,
    opts = {
        redraw = true,
        window_config = {},
    },
}

local default_header = {
    type = "text",
    val = {
        [[                               __                ]],
        [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
        [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
        [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
        [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
        [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
        -- [[ ______   ______     ______     ______     __  __     __    __     ______     __   __   ]],
        -- [[/\__  _\ /\  == \   /\  __ \   /\  ___\   /\ \/ /    /\ "-./  \   /\  __ \   /\ "-.\ \  ]],
        -- [[\/_/\ \/ \ \  __<   \ \  __ \  \ \ \____  \ \  _"-.  \ \ \-./\ \  \ \  __ \  \ \ \-.  \ ]],
        -- [[   \ \_\  \ \_\ \_\  \ \_\ \_\  \ \_____\  \ \_\ \_\  \ \_\ \ \_\  \ \_\ \_\  \ \_\\"\_\]],
        -- [[    \/_/   \/_/ /_/   \/_/\/_/   \/_____/   \/_/\/_/   \/_/  \/_/   \/_/\/_/   \/_/ \/_/]],
          -- [[████████╗██████╗  █████╗  ██████╗██╗  ██╗███╗   ███╗ █████╗ ███╗   ██╗]],
          -- [[╚══██╔══╝██╔══██╗██╔══██╗██╔════╝██║ ██╔╝████╗ ████║██╔══██╗████╗  ██║]],
          -- [[   ██║   ██████╔╝███████║██║     █████╔╝ ██╔████╔██║███████║██╔██╗ ██║]],
          -- [[   ██║   ██╔══██╗██╔══██║██║     ██╔═██╗ ██║╚██╔╝██║██╔══██║██║╚██╗██║]],
          -- [[   ██║   ██║  ██║██║  ██║╚██████╗██║  ██╗██║ ╚═╝ ██║██║  ██║██║ ╚████║]],
          -- [[   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝]],
          -- [[ _____               _    __  __             ]],
          -- [[|_   _| __ __ _  ___| | _|  \/  | __ _ _ __  ]],
          -- [[  | || '__/ _` |/ __| |/ / |\/| |/ _` | '_ \ ]],
          -- [[  | || | | (_| | (__|   <| |  | | (_| | | | |]],
          -- [[  |_||_|  \__,_|\___|_|\_\_|  |_|\__,_|_| |_|]],
          -- [[ ______                      __                                   ]],
          -- [[/\__  _\                    /\ \      /'\_/`\                     ]],
          -- [[\/_/\ \/ _ __    __      ___\ \ \/'\ /\      \     __      ___    ]],
          -- [[   \ \ \/\`'__\/'__`\   /'___\ \ , < \ \ \__\ \  /'__`\  /' _ `\  ]],
          -- [[    \ \ \ \ \//\ \L\.\_/\ \__/\ \ \\`\\ \ \_/\ \/\ \L\.\_/\ \/\ \ ]],
          -- [[     \ \_\ \_\\ \__/.\_\ \____\\ \_\ \_\ \_\\ \_\ \__/.\_\ \_\ \_\]],
          -- [[      \/_/\/_/ \/__/\/_/\/____/ \/_/\/_/\/_/ \/_/\/__/\/_/\/_/\/_/]],
          -- [[ /$$$$$$$$                           /$$       /$$      /$$                    ]],
          -- [[|__  $$__/                          | $$      | $$$    /$$$                    ]],
          -- [[   | $$  /$$$$$$  /$$$$$$   /$$$$$$$| $$   /$$| $$$$  /$$$$  /$$$$$$  /$$$$$$$ ]],
          -- [[   | $$ /$$__  $$|____  $$ /$$_____/| $$  /$$/| $$ $$/$$ $$ |____  $$| $$__  $$]],
          -- [[   | $$| $$  \__/ /$$$$$$$| $$      | $$$$$$/ | $$  $$$| $$  /$$$$$$$| $$  \ $$]],
          -- [[   | $$| $$      /$$__  $$| $$      | $$_  $$ | $$\  $ | $$ /$$__  $$| $$  | $$]],
          -- [[   | $$| $$     |  $$$$$$$|  $$$$$$$| $$ \  $$| $$ \/  | $$|  $$$$$$$| $$  | $$]],
          -- [[   |__/|__/      \_______/ \_______/|__/  \__/|__/     |__/ \_______/|__/  |__/]],
    },
    opts = {
        position = "center",
        hl = "Type",
        -- hl = "Number",
        -- wrap = "overflow";
    },
}

local footer = {
    type = "text",
    val = "Unleash your potential",
    opts = {
        position = "center",
        hl = "Number",
    },
}

local leader = "SPC"

--- @param sc string
--- @param txt string
--- @param keybind string? optional
--- @param keybind_opts table? optional
local function button(sc, txt, keybind, keybind_opts)
    local sc_ = sc:gsub("%s", ""):gsub(leader, "<leader>")

    local opts = {
        position = "center",
        shortcut = sc,
        cursor = 5,
        width = 50,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }
    if keybind then
        keybind_opts = if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
        opts.keymap = { "n", sc_, keybind, keybind_opts }
    end

    local function on_press()
        local key = vim.api.nvim_replace_termcodes(keybind or sc_ .. "<Ignore>", true, false, true)
        vim.api.nvim_feedkeys(key, "t", false)
    end

    return {
        type = "button",
        val = txt,
        on_press = on_press,
        opts = opts,
    }
end

local buttons = {
    type = "group",
    val = {
        button("e", "  New file", "<cmd>enew<CR>", nil),
        button("C-p", "  Find file", ":Telescope find_files<CR>", nil),
        button("SPC e", "  File Browser", ":Neotree float toggle<CR>", nil),
        button("SPC o p", "  Recently opened projects", ":Telescope projects<CR>", nil),
        -- button("SPC f r", "  Frecency/MRU", nil),
        -- button("SPC f m", "  Jump to bookmarks", nil),
        -- button("SPC s l", "  Open last session", nil),
    },
    opts = {
        spacing = 1,
    },
}

local section = {
    -- terminal = default_terminal,
    header = default_header,
    buttons = buttons,
    -- footer = footer,
}

local config = {
    layout = {
        { type = "padding", val = 12 },
        section.header,
        section.footer,
        { type = "padding", val = 2 },
        section.buttons,
    },
    opts = {
        margin = 5,
    },
}

return {
    button = button,
    section = section,
    config = config,
    -- theme config
    leader = leader,
    -- deprecated
    opts = config,
}
