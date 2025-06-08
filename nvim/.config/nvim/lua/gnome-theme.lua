-- if gsettings is not present skip this
if vim.fn.executable "gsettings" ~= 1 then return end
-- if we're not using gnome there is no reason to run this
if vim.env.DESKTOP_SESSION ~= "gnome" then return end

local cmd = [[
gsettings get org.gnome.desktop.interface color-scheme;
gsettings monitor org.gnome.desktop.interface color-scheme
]]

local function on_stdout()
  return function(_, data, _)
    local scheme = "tokyonight-night"
    if not string.match(data[1], "dark") then scheme = "tokyonight-day" end
    pcall(vim.cmd.colorscheme, scheme)
  end
end

vim.fn.jobstart(cmd, { on_stdout = on_stdout() })
