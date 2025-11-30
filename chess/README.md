# Chess.lua [![Build Status](https://app.travis-ci.com/arizati/chess.lua.svg?branch=master)](https://app.travis-ci.com/arizati/chess.lua)

- A basic chess library ported from https://github.com/jhlywa/chess.js
- Without chess engine.
- For lua5.1, it is recommended to use extra bit manipulation library to improve performance.

## Example

```lua
local Chess = require('chess')
local chess = Chess()
math.randomseed(os.time())
while true do
    local moves = chess.moves()
    if #moves == 0 then
        break
    else
        local idx = math.random(1, #moves)
        local move = moves[idx]
        chess.move(move)
    end
    local over, result, reason = chess.game_over()
    if over then
        print(result, reason)
        break
    end
end
print(chess.pgn())
```

## API

The APIs are the same as [jhlywa's chess.js](https://github.com/jhlywa/chess.js).

See this https://github.com/jhlywa/chess.js/blob/master/README.md#api
