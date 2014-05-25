//
//  DMToolPalleteController.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMUIProtocol.h"

@class DMToolsPalleteVIew;

@interface DMToolPalleteController : UIViewController<DMUIProtocol>

@property (nonatomic, weak, readonly) DMToolsPalleteVIew *toolPalleteView;

+(instancetype) createWithView:(DMToolsPalleteVIew*) view;

@end
