//
//  DMSelectTool.m
//  DriskelMator
//
//  Created by Brolis on 5/2/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMSelectTool.h"
#import "DMNotifications.h"
#import "DMToolInventory.h"
#import "DMCanvas.h"

@implementation DMSelectTool

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
    return @"select.png";
}

+(instancetype) createWithFrame:(CGRect) frame andCanvasState:(DMAbstarctState*) canvasState
{
    return [[DMSelectTool alloc] initWithFrame:frame andCanvasState:canvasState];
}

-(void) buttonReleased
{
    self.backgroundColor    = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.f];
    [self setSelected:NO];
}

-(void) buttonPressed
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DMSelectStateNotification object:self];
    
    [[DMToolInventory sharedInstance] unselectAllTools];
    [[DMCanvas sharedInstance] setState:self.canvasState];
    
    [self setSelected:YES];
    self.backgroundColor    = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:1.f];
    
}

@end
