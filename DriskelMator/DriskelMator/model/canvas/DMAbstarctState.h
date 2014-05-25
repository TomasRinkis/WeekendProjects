//
//  DMAbstarctState.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMUIProtocol.h"

@class DMCanvas;

@interface DMAbstarctState : NSObject<DMUIProtocol>

@property(nonatomic, strong, readonly) DMCanvas  *canvas;
@property(nonatomic) CGRect debugBBox;
@property(nonatomic) GLKVector2 touchBeginPos;
@property(nonatomic) GLKVector2 touchMovedPos;

-(id) initWithCanvas:(DMCanvas*) canvas;
@end
