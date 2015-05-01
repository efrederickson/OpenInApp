//
//  OIAScripts.m
//  OpenInApp
//
//  Created by Elijah Frederickson on 4/28/15.
//  Copyright (c) 2015 Elijah Frederickson. All rights reserved.
//

#import "OIAScripts.h"

@implementation OIAScripts
+(NSString*) mainScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"main" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}

+(NSString*) browserChangerScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Browser Changer" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) cydiaScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Cydia" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) ebayScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Ebay" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) foapScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Foap" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) githubScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"GitHub" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) imdbScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"IMDB" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) instagramScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Instagram" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) mailto2GmailScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Mailto 2 Gmail" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) mapsChangerScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"MapsChanger" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) tweetbotScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Tweetbot" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) twitterScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Twitter" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) twitterrificScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Twitterrific" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) vineScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Vine" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) appdotnetScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"AppDotNet" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
+(NSString*) amazonScript
{
    return [NSString stringWithContentsOfFile:[NSBundle.mainBundle pathForResource:@"Amazon" ofType:@"lua" inDirectory:@"scripts"] encoding:NSUTF8StringEncoding error:nil];
}
@end
