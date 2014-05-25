//
//  DMCreateRectState.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMAbstarctState.h"

@interface DMCreateRectState : DMAbstarctState

+(DMCreateRectState*) createWithCanvas:(DMCanvas*) canvas;

@end
