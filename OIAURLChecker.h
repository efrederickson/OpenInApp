//
//  OIAURLChecker.h
//  OpenInApp
//
//  Created by Elijah Frederickson on 4/29/15.
//  Copyright (c) 2015 Elijah Frederickson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OIAURLChecker : NSObject
+(BOOL) canOpenURL:(NSURL*)url;
+(BOOL) openURL:(NSURL*)url;
@end
