functions = { }
_G.functions = functions

-- block some "dangerous" stuff not removed from the modified Lua core
os.exit = nil
os.setlocale = nil
os.remove = nil
os.tmpname = nil
os.rename = nil
package = nil
require = nil

return function(str)
    --print(str)
    for k, v in pairs(functions) do
        local mod = v(str)
        --print("mod: " .. mod)
        if mod and mod ~= str and mod:len() > 0 then return mod end
    end
    return str
end
