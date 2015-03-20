//
//  cellData.m
//  lari
//
//  Created by NextepMac on 1/26/15.
//  Copyright (c) 2015 NextepMac. All rights reserved.
//

#import "CellData.h"

@implementation CellData
@synthesize name, value, imageName, color, number;

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.name forKey:@"CellDataName"];
    [coder encodeObject:self.value forKey:@"CellDataValue"];
    [coder encodeObject:self.imageName forKey:@"CellDataImage"];
    [coder encodeObject:self.color forKey:@"CellDataColor"];
    [coder encodeObject:self.number forKey:@"CellDataNumber"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"CellDataName"];
        self.value = [coder decodeObjectForKey:@"CellDataValue"];
        self.imageName = [coder decodeObjectForKey:@"CellDataImage"];
        self.color = [coder decodeObjectForKey:@"CellDataColor"];
        self.number = [coder decodeObjectForKey:@"CellDataNumber"];

    }
    return self;
}


@end
