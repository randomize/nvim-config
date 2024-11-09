local le = function(name)
    return function()
        require("telescope").load_extension(name)
    end
end

local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

return {
    -- Fuzzy Finder (files, lsp, etc)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-media-files.nvim", config = le("media_files") },
            { "debugloop/telescope-undo.nvim", config = le("undo") },
        },
        cmd = "Telescope",
        version = false, -- telescope did only one release, so use HEAD for now
        keys = {
            {
                "<leader>ue",
                function()
                    toggle_telescope(harpoon:list())
                end,
                desc = "Find harpoon fil[e]s",
            },
            {
                "<leader>ur",
                function()
                    require("telescope.builtin").oldfiles()
                end,
                desc = "Find [r]ecently opened files",
            },
            {
                "<leader>uu",
                function()
                    require("telescope.builtin").resume()
                end,
                desc = "[u] Resume last picker",
            },
            { "<leader>ut", ":Telescope<CR>", { noremap = true, silent = true, desc = "Telescope" } },
            {
                "<leader>ua",
                function()
                    require("telescope.builtin").find_files({ hidden = true, no_ignore = true, search_dirs = {"/home/randy/"} })
                end,
                desc = "Search [A]ll files",
            },
            {
                "<leader>uf",
                function()
                    require("telescope.builtin").find_files({ hidden = false, no_ignore = true })
                end,
                desc = "Search [f]iles",
            },
            {
                "<leader>ub",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "Search [b]uffers",
            },
            {
                "<space>b",
                function()
                    require("telescope.builtin").buffers()
                end,
                desc = "Search [b]uffers",
            },
            {
                "<leader>uh",
                function()
                    require("telescope.builtin").help_tags()
                end,
                desc = "Search [h]elp",
            },
            {
                "<leader>us",
                function()
                    require("telescope.builtin").grep_string()
                end,
                desc = "[s]earch current word",
            },
            {
                "<leader>ug",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "Search by [g]rep",
            },
            {
                "<leader>ud",
                function()
                    require("telescope.builtin").diagnostics()
                end,
                desc = "Search [d]iagnostics",
            },
            {
                "<leader>uc",
                function()
                    -- You can pass additional configuration to telescope to change theme, layout, etc.
                    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    }))
                end,
                desc = "Fuzzily search in [c]urrent buffer",
            },
            {
                "<leader>up",
                function()
                    require("telescope.builtin").git_files()
                end,
                desc = "Fuzzily search in git files [p]",
            },
            {
                "<space>p",
                function()
                    require("telescope.builtin").git_files()
                end,
                desc = "Fuzzily search in git files [p]",
            },
            {
                "<leader>uc",
                function()
                    require("telescope.builtin").command_history()
                end,
                desc = "Fuzzily search [c]ommand history",
            },
            {
                "<leader>uq",
                function()
                    require("telescope.builtin").quickfix()
                end,
                desc = "Fuzzily search [q]uickfix history",
            },
            {
                "<leader>um",
                function()
                    require("telescope.builtin").marks()
                end,
                desc = "Fuzzily search [m]arks",
            },
            {
                "<leader>uz",
                function()
                    require("telescope.builtin").spell_suggest()
                end,
                desc = "Fuzzily search [m]arks",
            },
            {
                "<leader>u/",
                function()
                    require("telescope.builtin").current_buffer_fuzzy_find()
                end,
                desc = "Fuzzily search in buffer /",
            },
            {
                "<leader>un",
                function()
                    require("telescope").extensions.undo.undo()
                end,
                desc = "Fuzzily [un]do in buffer",
            },
            -- nnoremap <c-enter> <cmd>Telescope buffers<cr>
        },
        opts = {
            defaults = {
                file_ignore_patterns = {
                    "node_modules",
                },
                preview_title = "",
                prompt_title = "",
                results_title = "",
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                -- Use the bellow instead for a non-borders layout
                -- borderchars = {
                --   prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                --   results = { " " },
                --   preview = { " " },
                -- },
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
            extensions = {
                media_files = {
                    filetypes = { "png", "webp", "jpg", "jpeg", "pdf" },
                    find_cmd = "rg", -- find command (defaults to `fd`)
                },
                undo = {

                }
            },
            pickers = {
                find_files = {
                    preview_title = "",
                    prompt_title = "",
                    results_title = "",
                },
                help_tags = {
                    preview_title = "",
                    -- prompt_title = "",
                    results_title = "",
                },
                grep_string = {
                    preview_title = "",
                    -- prompt_title = "",
                    results_title = "",
                },
                live_grep = {
                    preview_title = "",
                    -- prompt_title = "",
                    results_title = "",
                },
                diagnostics = {
                    preview_title = "",
                    -- prompt_title = "",
                    results_title = "",
                },
            },
        },
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        cond = vim.fn.executable("cmake") == 1,
        init = function()
            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")
        end,
    },
}
