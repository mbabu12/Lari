//
//  WebViewController.m
//  lari
//
//  Created by NextepMac on 1/30/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import "WebViewController.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "InsideViewController.h"


@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  //  AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
  //  appDelegate -> rotate = YES;
    
    self.webView.delegate = self;
    
 //   NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
 //   [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    self.navigationItem.rightBarButtonItem = nil;
   
    NSData * dt = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
    NSString * temp = [[NSString alloc] initWithData:dt encoding:NSUTF8StringEncoding];

    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:path];
    [self.webView loadHTMLString:temp baseURL:baseURL];
   
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://nextep.ge/lari/data/%d%@", self.idValue, @"?last=yearAndTwoMonth"]];
    NSData *data=[NSData dataWithContentsOfURL:url];
    self.statData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
   
}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        InsideViewController * insideView = [InsideViewController alloc];
        [self presentViewController:insideView animated:YES completion:nil];
    }];
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

/*


-(void)viewDidAppear:(BOOL)animated
{
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    if (deviceOrientation != UIDeviceOrientationPortrait)
    {
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: UIDeviceOrientationPortrait] forKey:@"orientation"];
    }
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger: deviceOrientation] forKey:@"orientation"];
}
*/
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString * link = [NSString stringWithFormat:@"javascript:loadChart(%@)", self.statData];
    [self.webView stringByEvaluatingJavaScriptFromString:link];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
