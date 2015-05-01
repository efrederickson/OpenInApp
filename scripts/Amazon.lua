--[[
 http://amzn.com/B007Q4OVHQ -> amazon://content/item?id=B007Q4OVHQ
http://www.amazon.com/dp/B007Q4OVHQ/ref=cm_sw_su_dp -> amazon://content/item?id=B007Q4OVHQ
]]

functions[#functions+1] = function(url)
    local item1 = url:gmatch("amzn.com/(.+)")()
    local item2 = url:gmatch("amazon.com/dp/([^/]+)")()
    if item1 then
        return "amazon://content/item?id=" .. item1
    elseif item2 then
        return "amazon://content/item?id=" .. item2
    end
end
