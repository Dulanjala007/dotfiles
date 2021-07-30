
local M = {}

M.find_files_with_hidden = function()
  local status_ok, telescope_builtin = pcall(require, "telescope.builtin")
  if not status_ok then
    return
  end

 telescope_builtin.find_files {
    find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
  }

end

return M
