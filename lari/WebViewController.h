//
//  WebViewController.h
//  lari
//
//  Created by NextepMac on 1/30/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

@interface WebViewController : BaseNavigationController<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (assign, nonatomic) NSInteger  idValue;
@property (strong, nonatomic) NSString * statData;

@end
