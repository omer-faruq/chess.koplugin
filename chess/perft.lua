local Chess = require("src/chess")
local chess = Chess()

local depth = tonumber(arg[1])

-- perft(1) --> 20
-- perft(2) --> 400
if depth and depth > 0 then
    local start = os.clock()

    print(("perft(%d) --> %d"):format(depth, chess.perft(depth)))

    local endt = os.clock()
    print(tostring(endt - start))
else
    print("Usage: lua perft.lua depth")
end
