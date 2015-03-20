//
//  BaseNavigationController.m
//  Unison Mobile
//
//  Created by levani on 11/20/14.
//  Copyright (c) 2014 Nextep. All rights reserved.
//

#import "BaseNavigationController.h"
#import "WebViewController.h"
#import "Reachability.h"


@implementation BaseNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor: [UIColor colorWithRed:63.0/255.0 green:179.0/255.0 blue:128.0/255.0 alpha:1.0]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    
    UINavigationItem *item = self.navigationItem;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"Chart.png"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 23, 23);
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus != NotReachable) {
    
        if ([self respondsToSelector:@selector(homeHandler:)]) {
            [button addTarget:self action:@selector(homeHandler:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 23, 23)];
    [view addSubview:button];
    UIBarButtonItem *home = [[UIBarButtonItem alloc] initWithCustomView:view];
    item.rightBarButtonItem = home;
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)homeHandler:(id)sender
{
}

@end
