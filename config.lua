-- config.lua — все настраиваемые параметры

local config = {}

-- Адреса транспозеров
config.addresses = {
  t_input = "2dcc9a91-441a-4780-bb31-ddcc44c71558",
  t_central = "dd8a20d5-3f98-4ec7-98a5-1877d2e1bcff",
  t_output = "11b6378d-fc57-4b8a-988a-23f5b96ec1e3"
}

-- Стороны
config.sides = {
  SIDE_INPUT_CHEST = 1,     -- sides.top
  SIDE_INPUT_BUFFER = 3,    -- sides.south
  SIDE_BUFFER_IN = 2,       -- sides.north
  SIDE_BUFFER_OUT = 3,      -- sides.south
  SIDE_BANK = 4,            -- sides.west
  SIDE_OUTPUT_BUFFER = 2,   -- sides.north
  SIDE_WIN_CHEST = 1        -- sides.top
}

-- Параметры игры
config.REQUIRED_AMOUNT = 10
config.MAX_WIN = 100
config.LOG_PATH = "/casino_log.txt"

return config
