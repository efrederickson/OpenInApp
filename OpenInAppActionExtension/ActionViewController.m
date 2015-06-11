//
//  ActionViewController.m
//  OpenInAppActionExtension
//
//  Created by Elijah Frederickson on 4/28/15.
//  Copyright (c) 2015 Elijah Frederickson. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <objc/message.h>
#import <objc/runtime.h>
#import "OIAScripts.h"
#import "OIALuaBinding.h"
#import "OIAURLChecker.h"
#import "MBProgressHUD.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface ActionViewController () {
    OIALuaBinding *lua;
    
    __weak MBProgressHUD *hud;
}

@end

@implementation ActionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.urlLabel.hidden = YES;
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.superview sendSubviewToBack:hud];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading URL...";
    
    lua = [[OIALuaBinding alloc] init];
}

-(void) viewDidAppear:(BOOL)animated
{
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeURL]) {
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeURL options:nil completionHandler:^(NSURL *url1, NSError *error) {
                    NSString *url = nil;
                    if (url1)
                        url = url1.absoluteString;
                    
                    if (!url)
                        return;
                    
                    NSLog(@"Got url: %@", url);
                    
                    [self.urlLabel performSelectorOnMainThread:@selector(setText:) withObject:url waitUntilDone:YES];
                    
                    hud.labelText = @"Processing URL...";
                    
                    [self modifyAndGo:url1];
                }];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) modifyAndGo:(NSURL*)url
{
    NSString *new = [lua modify:url.absoluteString];
    self.urlLabel.text = new;
    
    BOOL isSame = [new isEqualToString:url.absoluteString];
    
    NSLog(@"New url: \"%@\" is same: %@", new, isSame ? @"YES" : @"NO");
    
    if (isSame)
    {
        [hud hide];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed" message:@"Input and output URLs are the same.\nThere may be no installed app capable of handling this web site, or no processor for OpenInApp for handling this web site." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self done];
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
        [self goButtonTap];
}

-(void) goButtonTap
{
    NSURL *url = [NSURL URLWithString:self.urlLabel.text];
    
    //hud.labelText = @"Opening URL...";
    [hud performSelectorOnMainThread:@selector(hide) withObject:nil waitUntilDone:YES];
    
    [self.urlLabel performSelectorOnMainThread:@selector(setText:) withObject:@"Just press \"done\" to exit." waitUntilDone:NO];
    [self.urlLabel performSelectorOnMainThread:@selector(setHidden:) withObject:(id)kCFBooleanTrue waitUntilDone:NO];
    
    /*if (SYSTEM_VERSION_LESS_THAN(@"8.3") && NO) // we can use this "valid" solution/workaround
    {
        // crashes the extension, lol
        NSLog(@"Opening via UIWebView");
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        NSString *content = [NSString stringWithFormat:@"<head><meta http-equiv='refresh' content='0; URL=%@'></head>", url.absoluteString];
        [webView loadHTMLString:content baseURL:nil];
        [self.view performSelectorOnMainThread:@selector(addSubview:) withObject:webView waitUntilDone:NO];
        [webView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
    }
    else*/
        [OIAURLChecker performSelectorInBackground:@selector(openURL:) withObject:url];
    
    [self performSelectorOnMainThread:@selector(done) withObject:nil waitUntilDone:NO];
    
    /*
    // This first one (extensionContext) will always fail unless apple changes their rule on Actions opening urls...
    [self.extensionContext openURL:url completionHandler:^(BOOL success) {
    BOOL success = NO;
        if (!success)
        {
            if (NO && SYSTEM_VERSION_LESS_THAN(@"8.3")) // we can use this "valid" solution/workaround
            {
                NSLog(@"Opening via UIWebView");
                UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
                NSString *content = [NSString stringWithFormat:@"<head><meta http-equiv='refresh' content='0; URL=%@'></head>", url.absoluteString];
                [webView loadHTMLString:content baseURL:nil];
                [self.view addSubview:webView];
                [webView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
                
                
                self.urlLabel.text = @"Just press \"done\" to exit.";
                self.urlLabel.hidden = NO;
                //[self done];

                return;
            }
            else
            {
                //success = (BOOL)[[UIApplication performSelector:@selector(sharedApplication)] performSelector:@selector(openURL:) withObject:url];
                
                // ain't no fool here
                // +[OIAURLChecker openURL:url];
                
                success = ((BOOL (*)(id, SEL, id))objc_msgSend)(objc_getClass("OIAURLChecker"), @selector(openURL:), url);
            
                if (success)
                {
                    self.urlLabel.text = @"Just press \"done\" to exit.";
                    self.urlLabel.hidden = NO;
                    //[self done];
                }
                else
                {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed" message:@"Failed to open URL" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        [self done];
                    }];
                    [alert addAction:okAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
        }
    }];
    */
}

- (IBAction)done
{
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

@end
