//
//  OIAURLChecker.m
//  OpenInApp
//
//  Created by Elijah Frederickson on 4/29/15.
//  Copyright (c) 2015 Elijah Frederickson. All rights reserved.
//

#import "OIAURLChecker.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>

__strong id __app;

@implementation OIAURLChecker

+(void) loadUIApplication
{
    // +[UIApplication sharedApplication]
    __app = ((id (*)(id, SEL, id))objc_msgSend)(objc_getClass("UIApplication"), NSSelectorFromString(@"sharedApplication"), nil);
}

+(BOOL) canOpenURL:(NSURL*)url
{
    [self loadUIApplication];
    return ((BOOL (*)(id, SEL, id))objc_msgSend)(__app, @selector(canOpenURL:), url);
}

+(BOOL) openURL:(NSURL*)url
{
    [self loadUIApplication];
    return ((BOOL (*)(id, SEL, id))objc_msgSend)(__app, @selector(openURL:), url);
}
@end
