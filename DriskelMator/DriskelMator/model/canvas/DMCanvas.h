//
//  DMCanvas.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMUIProtocol.h"

@class DMAbstarctState;
@class DMAbtractElement;

@interface DMCanvas : NSObject<DMUIProtocol>

@property (nonatomic, strong) DMAbstarctState *state;
@property (nonatomic, strong, readonly) NSMutableArray *elementArray;
@property (nonatomic, weak) DMAbtractElement *selectedElement;
@property (nonatomic)   GLKVector4 background;

-(void) unselectAllElement;

+(DMCanvas*) sharedInstance;
+(DMAbstarctState*) createRectangleState;
+(DMAbstarctState*) createOvalState;
+(DMAbstarctState*) createSelectState;
+(DMAbstarctState*) createMoveState;
+(DMAbstarctState*) createRotateState;
+(DMAbstarctState*) createPusherState;
+(DMAbstarctState*) createTrashState;

@end
