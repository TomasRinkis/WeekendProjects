//
//  DMToolsPalleteVIew.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMUIProtocol.h"

@interface DMToolsPalleteVIew : UIView

@property(nonatomic, weak) id<DMUIProtocol> controllerDelegate;

+(instancetype) createWithFrame:(CGRect) rect;
@end
