//
//  MainViewCell.m
//  lari
//
//  Created by NextepMac on 1/26/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import "MainViewCell.h"


@implementation MainViewCell

@synthesize flagImage, currencyLabel, valueLabel, numberLabel;

-(void)setCellData:(CellData *)Data{
    [self.flagImage setImage:[UIImage imageNamed:Data.imageName]];
    [self.currencyLabel setText:Data.name];
    [self.valueLabel setText:Data.value];
    [self.numberLabel setText:Data.number];
    self.numberLabel.textColor = Data.color;
}

@end
