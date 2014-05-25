//
//  DMAbstarctState.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMAbstarctState.h"
#import "DMException.h"

@implementation DMAbstarctState

@synthesize canvas          = _canvas;
@synthesize debugBBox       =_debugBBox;
@synthesize touchBeginPos   = _touchBeginPos;
@synthesize touchMovedPos   = _touchMovedPos;


- (void)touchesBegan:(NSSet *)touches inPos:(GLKVector2) pos
{
    _touchBeginPos = pos;
}

- (void)touchesMoved:(NSSet *)touches inPos:(GLKVector2) pos
{
    _touchMovedPos = pos;
}

- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos
{
    _touchBeginPos  = GLKVector2Make(0.f, 0.f);
    _touchMovedPos  = GLKVector2Make(0.f, 0.f);
}

- (void)touchesCancelled:(NSSet *)touches inPos:(GLKVector2) pos
{
    _touchBeginPos  = GLKVector2Make(0.f, 0.f);
    _touchMovedPos  = GLKVector2Make(0.f, 0.f);
}

- (void)update
{
}

- (void)draw
{
}

-(id) initWithCanvas:(DMCanvas*) canvas
{
    self = [super init];
    
    if(self)
    {
        _canvas         = canvas;
        _debugBBox      = CGRectZero;
        _touchBeginPos  = GLKVector2Make(0.f, 0.f);
        _touchMovedPos  = GLKVector2Make(0.f, 0.f);
    }
    
    return self;
}

@end
