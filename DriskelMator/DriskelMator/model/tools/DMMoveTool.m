//
//  DMMoveTool.m
//  DriskelMator
//
//  Created by Brolis on 5/2/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMMoveTool.h"
#import "DMToolInventory.h"
#import "DMCanvas.h"

@implementation DMMoveTool

-(id)initWithFrame:(CGRect)frame andCanvasState:(DMAbstarctState*) canvasState
{
    self = [super initWithFrame:frame andCanvasState:canvasState];
    
    if(self)
    {
        [self setImage:self.icon forState:UIControlStateNormal];
        [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

-(void) dealloc
{
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

-(NSString*) iconName
{
    return @"hand.png";
}

+(instancetype) createWithFrame:(CGRect) frame andCanvasState:(DMAbstarctState*) canvasState
{
    return [[DMMoveTool alloc] initWithFrame:frame andCanvasState:canvasState];
}

-(void) buttonReleased
{
    self.backgroundColor    = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.f];
    [self setSelected:NO];
}

-(void) buttonPressed
{
    [[DMToolInventory sharedInstance] unselectAllTools];
    [[DMCanvas sharedInstance] setState:self.canvasState];
    
    [self setSelected:YES];
    self.backgroundColor    = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:1.f];
    
}

@end

