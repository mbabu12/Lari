//
//  InsideViewController.h
//  lari
//
//  Created by NextepMac on 1/26/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellData.h"
#import "BaseNavigationController.h"
#import "MainViewCell.h"

@interface InsideViewController : BaseNavigationController<UITextFieldDelegate, UIScrollViewDelegate>{
    BOOL toGel;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) CellData * myValue;
@property (weak, nonatomic) IBOutlet UIImageView *flagImage;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *fromImage;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UITextField * activeField;
@property (weak, nonatomic) IBOutlet UIView *frontView;
@property (weak, nonatomic) IBOutlet UIButton *changeCur;
@property (strong, nonatomic) UITapGestureRecognizer * tapper;


@end
