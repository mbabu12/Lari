//
//  MainViewCell.h
//  lari
//
//  Created by NextepMac on 1/26/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CellData.h"

@interface MainViewCell : UITableViewCell


-(void)setCellData:(CellData *)Data;

@property (weak, nonatomic) IBOutlet UIImageView *flagImage;
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;



@end
