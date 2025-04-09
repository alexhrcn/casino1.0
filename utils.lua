-- utils.lua — логика и утилиты

local component = require("component")
local fs = require("filesystem")
local os = require("os")
local config = require("config")

local t_central = component.proxy(config.addresses.t_central)
local sides = config.sides

local utils = {}

-- Логирование
function utils.log(text)
  local f = io.open(config.LOG_PATH, "a")
  if f then
    f:write(os.date("[%Y-%m-%d %H:%M:%S] ") .. text .. "\n")
    f:close()
  end
end

-- Расчёт выигрыша
function utils.calculateWinnings()
  local roll = math.random(1, 1000)
  if roll <= 600 then return math.random(0, 20)      -- 60%
  elseif roll <= 900 then return math.random(21, 50) -- 30%
  elseif roll <= 995 then return math.random(51, 75) -- 9.5%
  else return math.random(76, config.MAX_WIN)        -- 0.5%
  end
end

-- Очистка буферов
function utils.clearBuffers()
  for slot = 1, t_central.getInventorySize(sides.SIDE_BUFFER_IN) do
    local stack = t_central.getStackInSlot(sides.SIDE_BUFFER_IN, slot)
    if stack then
      t_central.transferItem(sides.SIDE_BUFFER_IN, sides.SIDE_BANK)
    end
  end

  for slot = 1, t_central.getInventorySize(sides.SIDE_BUFFER_OUT) do
    local stack = t_central.getStackInSlot(sides.SIDE_BUFFER_OUT, slot)
    if stack then
      t_central.transferItem(sides.SIDE_BUFFER_OUT, sides.SIDE_BANK)
    end
  end
end

return utils
