//
//  DMAbsractTool.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMUIProtocol.h"

@class DMAbstarctState;
@interface DMAbsractTool : UIButton

@property(nonatomic, readonly, strong) id icon;
@property(nonatomic, readonly, strong) NSString *iconName;
@property(nonatomic, readonly, strong) DMAbstarctState *canvasState;


-(id) initWithFrame:(CGRect)frame andCanvasState:(DMAbstarctState*) canvasState;
-(void) buttonReleased;
-(void) buttonPressed;

+(int) dimension;
+(int) halfDimension;

@end
