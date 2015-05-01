functions[#functions+1] = function(url)
    if url:sub(1, 5) == 'maps:' then
        return "comgooglemaps://?" .. url:gsub("maps:address=", "maps:q="):gsub("maps:", "")
    end
    local web = url:gmatch("maps.apple.com-/maps?(.*)")() or url:gmatch("maps.apple.com-/?(.*)")()
    if web then 
    print(web)
        return "comgooglemaps://?" .. web
    end
end