-- casino.lua — логика казино

local component = require("component")
local config = require("config")
local utils = require("utils")
local ui = require("ui")

local t_input = component.proxy(config.addresses.t_input)
local t_central = component.proxy(config.addresses.t_central)
local t_output = component.proxy(config.addresses.t_output)

local sides = config.sides

local casino = {}

local function checkForStake()
  for slot = 1, t_input.getInventorySize(sides.SIDE_INPUT_CHEST) do
    local stack = t_input.getStackInSlot(sides.SIDE_INPUT_CHEST, slot)
    if stack and stack.name == "minecraft:diamond" and stack.size == config.REQUIRED_AMOUNT then
      t_input.transferItem(sides.SIDE_INPUT_CHEST, sides.SIDE_INPUT_BUFFER, config.REQUIRED_AMOUNT, slot)
      return true
    end
  end
  ui.displayCentered("Нужно ровно 10 алмазов!")
  return false
end

function casino.run()
  if checkForStake() then
    local win = utils.calculateWinnings()
    t_central.transferItem(sides.SIDE_BUFFER_IN, sides.SIDE_BANK, config.REQUIRED_AMOUNT)

    if win > 0 then
      t_central.transferItem(sides.SIDE_BANK, sides.SIDE_BUFFER_OUT, win)
      t_output.transferItem(sides.SIDE_OUTPUT_BUFFER, sides.SIDE_WIN_CHEST, win)
      ui.displayCentered("Поздравляем! Вы выиграли " .. win .. " алмазов!")
    else
      ui.displayCentered("Увы! Вы ничего не выиграли.")
    end

    utils.log("Ставка: 10 алмазов → выигрыш: " .. win)
    utils.clearBuffers()
    os.sleep(2)
  end
end

return casino
