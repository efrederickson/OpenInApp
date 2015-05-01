//
//  ViewController.m
//  OpenInApp
//
//  Created by Elijah Frederickson on 4/28/15.
//  Copyright (c) 2015 Elijah Frederickson. All rights reserved.
//

#import "ViewController.h"
#import <iAd/iAd.h>

@interface ViewController () {
    UILabel *mainLabel;
    
    BOOL bannerVisible;
    ADBannerView *adView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + 10, self.view.frame.origin.y + 10, self.view.frame.size.width - 20, self.view.frame.size.height - 20)];
    mainLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mainLabel.text = @"Welcome to OpenInApp!\n"
    "This is designed as an Action Extension so there's nothing here.\n"
    "Try opening the OpenInApp action extension in Safari!\n\n"
    "Currently supports: Amazon, Ebay, Foap, iOctocat, IMDB, Instagram, Google Maps, Tweetbot, Twitter, Twitterrific, Vine, App.net, and mailto: links; as well as redirecting to Google Chrome."
    ;
    [self.view addSubview:mainLabel];
    mainLabel.numberOfLines = 0;
    mainLabel.textAlignment = NSTextAlignmentCenter;
    
    adView = [[ADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 50)];
    adView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!bannerVisible)
    {
        // If banner isn't part of view hierarchy, add it
        if (adView.superview == nil)
        {
            [self.view addSubview:adView];
        }
        
        [UIView animateWithDuration:0.5 animations:^{
            banner.frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
        }];
        bannerVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed to retrieve ad");
}
@end
