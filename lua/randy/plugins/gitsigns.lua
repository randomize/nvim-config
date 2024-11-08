return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      -- numhl = true, -- uncomment to change the color of the numbers based on git diff
      signcolumn = true, -- show signs in the signcolumn
      sign_priority = 6,
      signs = {
        add = { text = "│", },
        change = { text = "│", },
        delete = { text = "_", },
        topdelete = { text = "‾", },
        changedelete = { text = "~", },
        untracked = { text = "┆", },
      },
      on_attach = function (bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end, { desc = "Next Hunk" })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end, { desc = "Prew Hunk" })

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk" })
        map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Stage Hunk" })
        map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = "Reset Hunk" })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Stage Buffer" })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Reset Buffer" })
        map('n', '<leader>hP', gitsigns.preview_hunk, { desc = "Preview Hunk" })
        map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end, { desc = "Blame Line" })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Toggle Blame" })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = "Diff Hunk" })
        map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Diff This Hunk" })
        map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "Toggel Deleted" })

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    },
  },
}
