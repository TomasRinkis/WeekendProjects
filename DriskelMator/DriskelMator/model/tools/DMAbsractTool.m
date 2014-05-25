//
//  DMAbsractTool.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMAbsractTool.h"

@implementation DMAbsractTool

@synthesize canvasState = _canvasState;

-(id) initWithFrame:(CGRect)frame andCanvasState:(DMAbstarctState*) canvasState;
{
    self = [super init];
    
    if(self)
    {
        self.frame = frame;
        _canvasState = canvasState;
        
//        [self setImage:self.icon forState:UIControlStateNormal];
//        [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchDown];
    }
    
    return self;
}

-(NSString*) iconName
{
    NSAssert(false, @"implement in super class!");
    return nil;
}

- (id) icon
{
    return [UIImage imageNamed:self.iconName];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
}


- (void)update
{
    
}

- (void)draw
{
    
}

-(void) buttonReleased
{
    self.backgroundColor    = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:0.f];
}

-(void) buttonPressed
{
    [self setSelected:YES];
    self.backgroundColor    = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:1.f];
}


+(int) dimension
{
    return 50;
}

+(int) halfDimension
{
    return [DMAbsractTool dimension]/2;
}


@end
