return function(bufname, _)
  print("Calculate root for C# project")

  local util = require 'lspconfig.util'
  local scan_dir = require 'plenary.scandir'.scan_dir
  local path = require 'plenary.path'

  local fallbackSln = nil
  local root = util.root_pattern('*.sln')(bufname)

  if root ~= nil then
    print("Found a root with sln "..root)
    return path.new(root):absolute()
  end

  local workspace_root = util.root_pattern('workspace.code-workspace')(bufname)
  -- local csproj = scan_dir(root, { depth = 2, search_pattern = "\\*.csproj$" })
  local solutions = scan_dir(root, { depth = 2, search_pattern = "\\*.sln$" })
  -- print('Root dir for '..bufname..' is '..root)

  if #solutions ~= 0 then
    for _, sln_path in pairs(solutions) do
      local match = string.match(sln_path, string.format('.*[/.]%s.sln', vim.g.project_name))
      if match then return path.new(sln_path):parent():absolute() end
    end

    fallbackSln = path.new(solutions[1]):parent():absolute()
  end

  local cwdSolutions = scan_dir(vim.fn.getcwd(), { depth = 1, search_pattern = "\\*.sln$" })
  if #cwdSolutions ~= 0 then
    -- print("CWD solutions "..cwdSolutions[1])
    return path.new(cwdSolutions[1]):parent():absolute()
  end

  if fallbackSln then
    return fallbackSln
  end

  csprojs = scan_dir(root, { depth = 2, search_pattern = "\\*.csproj$" })
  -- print(vim.inspect(result))
  if #csprojs ~= 0 then
    local path = path.new(csprojs[1]):parent():absolute()
    print("Return csproj[1] path: "..path)
    return path
  end
end
