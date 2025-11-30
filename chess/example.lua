local Chess = require('src/chess')
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
print(chess.ascii())
print(chess.fen())
print()
