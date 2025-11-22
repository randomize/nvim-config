local Path = require("plenary.path")
local scan_dir = require("plenary.scandir").scan_dir

local util_ok, util = pcall(require, "lspconfig.util")

-- session cache: .uniroot dir -> chosen .sln path
vim.g.uniroot_sln_cache = vim.g.uniroot_sln_cache or {}
local sln_cache = vim.g.uniroot_sln_cache

----------------------------------------------------------------------
-- helpers (sync)
----------------------------------------------------------------------

local function find_uniroot(start_dir)
  -- keep as absolute string
  local dir = Path:new(start_dir):absolute()

  while true do
    local marker = Path:new(dir):joinpath(".uniroot")
    if marker:exists() then
      return dir
    end

    local parent = Path:new(dir):parent():absolute()
    if parent == dir then
      return nil
    end

    dir = parent
  end
end

local function find_sln_under_uniroot(uniroot)
  -- cache per session
  local cached = sln_cache[uniroot]
  if cached and Path:new(cached):exists() then
    return cached
  end

  -- scan a few levels deep; your UnifiedGolf sln is at depth 2
  local sln_files = scan_dir(uniroot, {
    hidden = false,
    depth = 2, -- only 2 levels is fine
    add_dirs = false,
    search_pattern = "%.sln$",
  })

  table.sort(sln_files)

  if #sln_files == 0 then
    return nil
  end

  -- only one .sln → just use it
  if #sln_files == 1 then
    sln_cache[uniroot] = sln_files[1]
    return sln_files[1]
  end

  -- more than one → ask once per uniroot, then cache
  print("Multiple .sln files under " .. uniroot .. ":")
  for i, sln in ipairs(sln_files) do
    local rel = Path:new(sln):make_relative(uniroot)
    print(string.format("  %d) %s", i, rel))
  end

  local choice
  while true do
    local input = vim.fn.input("Choose solution number (empty = cancel): ")
    if input == nil or input == "" then
      break
    end
    local idx = tonumber(input)
    if idx and idx >= 1 and idx <= #sln_files then
      choice = sln_files[idx]
      break
    end
    print("Invalid selection, try again.")
  end

  if not choice then
    return nil
  end

  sln_cache[uniroot] = choice
  return choice
end

local function detect_root_dir_from_filename(filename)
  if not filename or filename == "" then
    return nil
  end

  local file_dir = Path:new(filename):parent():absolute()

  ------------------------------------------------------------------
  -- 1) Unity layout via .uniroot + one or more *.sln in subtree
  ------------------------------------------------------------------
  local uniroot = find_uniroot(file_dir)
  if uniroot then
    local sln = find_sln_under_uniroot(uniroot)
    if sln then
      -- parent dir of the .sln, e.g. /.../Unity.Product.UnifiedGolf
      return Path:new(sln):parent():absolute()
    end
    -- if .uniroot exists but no sln at all: fall through
  end

  ------------------------------------------------------------------
  -- 2) Generic fallback when there is no .uniroot
  --    (normal .NET projects etc.)
  ------------------------------------------------------------------
  if util_ok then
    local root =
      util.root_pattern("*.sln")(filename)
      or util.root_pattern(".git")(filename)

    if root then
      return root
    end
  end

  ------------------------------------------------------------------
  -- 3) Last fallback: directory of current file
  ------------------------------------------------------------------
  return file_dir
end

----------------------------------------------------------------------
-- exported function: supports BOTH APIs
--   - new: root_dir(bufnr, on_dir)
--   - old: root_dir(filename, bufnr) -> string|nil
----------------------------------------------------------------------

return function(a1, a2)
  -- New Nvim 0.11 API: root_dir(bufnr, on_dir)
  if type(a1) == "number" and type(a2) == "function" then
    local bufnr = a1
    local cb = a2

    local filename = vim.api.nvim_buf_get_name(bufnr)
    local root = detect_root_dir_from_filename(filename)
    cb(root)
    return
  end

  -- Old API: root_dir(filename, bufnr) -> string|nil
  local filename = a1
  if (not filename or filename == "") and type(a2) == "number" then
    filename = vim.api.nvim_buf_get_name(a2)
  end

  return detect_root_dir_from_filename(filename)
end
