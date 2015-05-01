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

__weak id __app;

@implementation OIAURLChecker

+(UIApplication*) loadUIApplication
{
    // cast objc_msgSend
    
    // +[UIApplication sharedApplication]
    __app = ((id (*)(id, SEL, id))objc_msgSend)(objc_getClass("UIApplication"), NSSelectorFromString(@"sharedApplication"), nil);
    return __app;
}

+(BOOL) canOpenURL:(NSURL*)url
{
    [self loadUIApplication];
    assert(__app);
    
    // -[UIApplication canOpenURL:]
    //return msgSend((__bridge void*)application, @selector(canOpenURL:), (__bridge void*)[NSURL URLWithString:scheme]);
    return ((BOOL (*)(id, SEL, id))objc_msgSend)(__app, @selector(canOpenURL:), url);
    //return [UIApplication$sharedApplication performSelector:@selector(canOpenURL:) withObject:url];
}

+(BOOL) openURL:(NSURL*)url
{
    [self loadUIApplication];
    assert(__app);
    
    // -[UIApplication openURL:]
    //return [UIApplication$sharedApplication performSelector:@selector(openURL:) withObject:url];
    
    //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        ((BOOL (*)(id, SEL, id))objc_msgSend)(__app, @selector(openURL:), url);
    //});
    
    return YES;
    //return ((BOOL (*)(id, SEL, id))objc_msgSend)(__app, @selector(openURL:), url);
}
@end
