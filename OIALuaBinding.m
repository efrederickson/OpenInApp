#import "OIALuaBinding.h"
#import "lua/lua.h"
#import "lua/lualib.h"
#import "lua/lauxlib.h"
#import "OIAScripts.h"
#import "OIAURLChecker.h"

#define CHECK_SCHEME(sch, pth) \
    if ([OIAURLChecker canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",sch]]]) \
        [self doString:[OIAScripts pth]];

@implementation OIALuaBinding
-(id) init
{
    id obj = [super init];
    [self createNewLua];
    return obj;
}
    
-(void) disposeOfLua
{
    if (L)
        lua_close(L);
    L = NULL;
}

-(void) doString:(NSString*)str
{
    if (str == nil)
    {
        NSLog(@"nil string passed to -[OIALuaBinding doString:]");
        return;
    }
    
    if (luaL_dostring(L, [str UTF8String]) != LUA_OK)
    {
        const char *err = lua_tostring(L, -1);
        NSString *err2 = [NSString stringWithFormat:@"%s", err];
        NSLog(@"Lua Execution Error: %@", err2);
        @throw err2;
    }
}

-(void) createNewLua
{
    // init Lua
    L = luaL_newstate();
    luaL_openlibs(L);
    
    // load main Lua script
    if(luaL_loadstring(L, [OIAScripts.mainScript UTF8String]) != LUA_OK || lua_pcall(L, 0, 1, 0) != 0)
    {
        NSLog(@"L2A: failed to load main script: %s", lua_tostring(L, -1));
    }
    else if(!lua_isfunction(L, -1))
    {
        NSLog(@"L2A: failed to load main script: return value was not a function");
    }
    else
    {
        //NSLog(@"L2A: loaded main script");
        lua_pushvalue(L, -1);
        funcIndex = luaL_ref(L, LUA_REGISTRYINDEX);
    }
    
    lua_pop(L, 1);
    
    CHECK_SCHEME(@"cydia", cydiaScript);
    CHECK_SCHEME(@"ebay", ebayScript);
    CHECK_SCHEME(@"foap", foapScript);
    CHECK_SCHEME(@"ioc", githubScript); // iOctocat
    CHECK_SCHEME(@"imdb", imdbScript);
    CHECK_SCHEME(@"instagram", instagramScript);
    CHECK_SCHEME(@"comgooglemaps", mapsChangerScript);
    CHECK_SCHEME(@"tweetbot", tweetbotScript);
    CHECK_SCHEME(@"twitter", twitterScript);
    CHECK_SCHEME(@"twitterrific", twitterrificScript);
    CHECK_SCHEME(@"vine", vineScript);
    CHECK_SCHEME(@"netbot", appdotnetScript);
    CHECK_SCHEME(@"amazon", amazonScript);
    
    CHECK_SCHEME(@"googlechrome", browserChangerScript);
    
    [self doString:[OIAScripts mailto2GmailScript]];
}
    
-(NSString*) modify:(NSString*)input
{
    lua_rawgeti(L, LUA_REGISTRYINDEX, funcIndex);
    NSString *temp = [[NSString alloc] initWithFormat:@"%@", input];
    const char *str = [temp UTF8String];
    lua_pushstring(L, str);
    if (lua_pcall(L, 1, 1, 0) != 0)
    {
        // log error
        NSLog(@"L2A: failed to modify url %s", lua_tostring(L, -1));
        return input;
    }
    else
    {
        const char *result = lua_tostring(L, -1);
        return [NSString stringWithUTF8String:result];
    }
}
@end