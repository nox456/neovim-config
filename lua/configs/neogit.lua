-- Neogit's status buffer opens a file with a plain `:edit`, in whichever window happens to
-- be current after the status buffer closes itself. When that window holds a terminal (a
-- `<leader>tt` tab, the Claude Code split), the file takes the terminal's window over and
-- the terminal is pushed out of sight. Neogit's commit view already guards against this by
-- focusing a real file window first, so wrap `jump.open` to make `GoToFile` from the status
-- buffer behave the same way.

local api = vim.api
local jump = require "neogit.lib.jump"
local open = jump.open

---A window a file may be opened into: on screen, not floating, not owned by a plugin.
---@param win integer
---@return boolean
local function is_editable_window(win)
  if not api.nvim_win_is_valid(win) or api.nvim_win_get_config(win).relative ~= "" then
    return false
  end

  local buf = api.nvim_win_get_buf(win)
  local filetype = vim.bo[buf].filetype

  -- nvdash is a scratch buffer, but replacing the dashboard is the point of opening a file
  -- while it is up.
  if filetype == "nvdash" then
    return true
  end

  return vim.bo[buf].buftype == "" and not vim.startswith(filetype, "Neogit")
end

---Tabs in the order neogit itself checks them: current, last visited, then the rest.
---@return integer[]
local function ordered_tabpages()
  local current = api.nvim_get_current_tabpage()
  local previous = vim.fn.tabpagenr "#"
  local order = { current }

  for _, tab in ipairs(api.nvim_list_tabpages()) do
    if tab ~= current and api.nvim_tabpage_get_number(tab) == previous then
      table.insert(order, tab)
    end
  end

  for _, tab in ipairs(api.nvim_list_tabpages()) do
    if not vim.tbl_contains(order, tab) then
      table.insert(order, tab)
    end
  end

  return order
end

---@return boolean true when a window was focused
local function focus_editable_window()
  for _, tab in ipairs(ordered_tabpages()) do
    for _, win in ipairs(api.nvim_tabpage_list_wins(tab)) do
      if is_editable_window(win) then
        api.nvim_set_current_tabpage(tab)
        api.nvim_set_current_win(win)
        return true
      end
    end
  end

  return false
end

jump.open = function(command, path, cursor, debug_prefix)
  -- `split`, `vsplit` and `tabedit` make their own window, so only a bare `edit` can
  -- clobber the window it lands in.
  if command == "edit" and not is_editable_window(api.nvim_get_current_win()) then
    if not focus_editable_window() then
      vim.cmd "tabnew"
    end
  end

  open(command, path, cursor, debug_prefix)
end
