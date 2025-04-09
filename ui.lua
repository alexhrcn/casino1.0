-- ui.lua — интерфейс отображения на экране

local component = require("component")
local term = require("term")
local unicode = require("unicode")

local gpu = component.gpu
local screen_w, screen_h = gpu.getResolution()

local ui = {}

function ui.displayCentered(text)
  term.clear()
  local x = math.floor((screen_w - unicode.len(text)) / 2)
  local y = math.floor(screen_h / 2)
  term.setCursor(x, y)
  print(text)
end

return ui
