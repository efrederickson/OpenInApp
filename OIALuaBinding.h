#import <Foundation/Foundation.h>
#import "lua/lua.h"

@interface OIALuaBinding : NSObject
{
    lua_State *L;
    int funcIndex;
}
-(id) init;
-(NSString*) modify:(NSString*)input;
-(void) disposeOfLua;
-(void) createNewLua;
@end