//
//  DMRectElement.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMAbtractElement.h"

@interface DMRectElement : DMAbtractElement

@property (nonatomic) CGRect bounds;

+(instancetype) createWithBounds:(CGRect) bounds translation:(GLKMatrix4) translation andRotation:(GLKMatrix4)rotation;

@end
