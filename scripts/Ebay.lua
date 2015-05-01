functions[#functions+1] = function(url)
    --local item = url:gmatch("ebay.com/itm/(%d+)")()
    local item = url:gmatch("ebay.[^/]+/itm/(%d+)")()
    local item2 = url:gmatch("ebay.[^/]+/itm/[^/]+/(%d+)")()
    local search = url:gmatch("ebay.[^/]+/sch/[^&]+&_nkw=([%w_+]+)")()
    if item then
        return "ebay://launch?itm=" .. item
    elseif item2 then
        return "ebay://launch?itm=" .. item2
    elseif search then
        return "ebay://sch/i.html?_nkw=" .. search
    end
end