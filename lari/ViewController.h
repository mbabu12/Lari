//
//  ViewController.h
//  lari
//
//  Created by NextepMac on 1/26/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"
#import "BaseNavigationController.h"
#import "GAITrackedViewController.h"
#import "MainViewCell.h"

@class GADBannerView;

@interface ViewController : GAITrackedViewController<UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate>{
    NSMutableArray * arr;
    NSInteger count;
    BOOL isInternet;
}

@property (weak, nonatomic) IBOutlet UITableView *mainTable;
@property (weak, nonatomic) IBOutlet UIButton *statisticsButton;
@property (strong, nonatomic) NSString * elName;
@property (strong, nonatomic) CellData * clicked;
@property (strong, nonatomic) NSDate * now;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UILabel *dataTitleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;



@end

