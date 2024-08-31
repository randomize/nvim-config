return function(f, b)

  print("Calculate root for C# project")

  local util = require 'lspconfig.util'
  local scan_dir = require 'plenary.scandir'.scan_dir
  local path = require 'plenary.path'

  -- Helper function to recursively search for *.sln files
  local function find_sln_files(dir)
      return scan_dir(dir, { hidden = true, depth = 10, search_pattern = "%.sln$" })
  end

  -- Helper function to check if the directory contains a 'ProjectSettings' directory
  local function is_unity_project(dir)
      return path:new(dir):joinpath("ProjectSettings"):is_dir()
  end

  -- Helper function to interactively ask user to choose from multiple *.sln files
  local function choose_sln(sln_files)
      for i, sln in ipairs(sln_files) do
          print(string.format("%d: %s", i, sln))
      end
      print("Choose a solution file by number:")
      local choice = tonumber(vim.fn.input("> "))
      return sln_files[choice]
  end

  -- Main function to detect root directory
  local function detect_root_dir(filename, buffnr)
      local dir = path:new(filename):parent()

      while dir do
          -- Check if current directory name starts with "Unity."
          if dir.filename:match("^Unity%.") then
              -- Unity algorithm
              print("Unity: " .. dir.filename)

              local sln_files = find_sln_files(dir.filename)
              if #sln_files == 1 then
                  if is_unity_project(dir.filename) then
                      return dir.filename
                  end
              elseif #sln_files > 1 then
                  local chosen_sln = choose_sln(sln_files)
                  if chosen_sln and is_unity_project(path:new(chosen_sln):parent().filename) then
                      return path:new(chosen_sln):parent().filename
                  end
              end
          else
              print("Unity: " .. dir.filename)
              -- Standard algorithm to find *.sln in parent directories
              local root = util.root_pattern("*.sln")(filename)
              if root then
                  return root
              end
          end
                                      -- Move to the parent directory
        local parent_dir = dir:parent()
        if parent_dir.filename == dir.filename then
            break
        end
        dir = parent_dir
      end
       -- Fallback to the directory where the file is located
      return path:new(filename):parent().filename
  end

  -- Usage
  -- local root_dir = function(filename, buffnr)
  return detect_root_dir(f, b)
end
  -- end

  -- return root_dir

-- return function(bufname, _)

  -- print("Calculate root for C# project")

--   local util = require 'lspconfig.util'
--   local scan_dir = require 'plenary.scandir'.scan_dir
--   local path = require 'plenary.path'
--
--   local fallbackSln = nil
--   local root = util.root_pattern('*.sln')(bufname)
--
--
--   if root ~= nil then
--     print("Found a root with sln "..root)
--     return path.new(root):absolute()
--   end
--
--   local root_files = {
--     '.sandbox.modules',
--     '.randge.modules'
--   }
--   root = util.root_pattern(unpack(root_files))(bufname)
--   -- print("Found a root with sln "..root)
--
--   --local workspace_root = util.root_pattern('workspace.code-workspace')(bufname)
--   -- local csproj = scan_dir(root, { depth = 2, search_pattern = "\\*.csproj$" })
--   local solutions = scan_dir(root, { depth = 2, search_pattern = "\\*.sln$" })
--   -- print('Root dir for '..bufname..' is '..root)
--
--   if #solutions ~= 0 then
--     for _, sln_path in pairs(solutions) do
--       local match = string.match(sln_path, string.format('.*[/.]%s.sln', vim.g.project_name))
--       if match then return path.new(sln_path):parent():absolute() end
--     end
--
--     fallbackSln = path.new(solutions[1]):parent():absolute()
--   end
--
--   local cwdSolutions = scan_dir(vim.fn.getcwd(), { depth = 1, search_pattern = "\\*.sln$" })
--   if #cwdSolutions ~= 0 then
--     -- print("CWD solutions "..cwdSolutions[1])
--     return path.new(cwdSolutions[1]):parent():absolute()
--   end
--
--   if fallbackSln then
--     return fallbackSln
--   end
--
--   local csprojs = scan_dir(root, { depth = 2, search_pattern = "\\*.csproj$" })
--   -- print(vim.inspect(result))
--   if #csprojs ~= 0 then
--     local path = path.new(csprojs[1]):parent():absolute()
--     -- print("Return csproj[1] path: "..path)
--     return path
--   end
-- end
