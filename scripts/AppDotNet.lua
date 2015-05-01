
functions[#functions+1] = function(url)
    local user = url:gmatch("alpha.app.net/(.+)")()
    if user then
        return "netbot:///user_profile/" .. user
    end
end

--if ([url.host isEqualToString:@"alpha.app.net"] && url.pathComponents.count == 2 && [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"netbot://"]]) {
--return [NSURL URLWithString:[@"netbot:///user_profile/" stringByAppendingString:url.pathComponents[1]]];