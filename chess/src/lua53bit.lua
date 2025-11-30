--local bit = require('bit')

--return bit

local ok, bit = pcall(require, 'bit')
if not ok then
    bit = require('bit32')
end

return bit