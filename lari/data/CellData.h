//
//  cellData.h
//  lari
//
//  Created by NextepMac on 1/26/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CellData : NSObject

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * value;
@property (strong, nonatomic) NSString * imageName;
@property (strong, nonatomic) NSString * number;
@property (strong, nonatomic) UIColor * color;

- (id)initWithCoder:(NSCoder *)coder;

@end
