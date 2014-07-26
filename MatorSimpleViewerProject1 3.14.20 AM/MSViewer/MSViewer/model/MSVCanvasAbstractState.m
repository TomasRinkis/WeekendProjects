//
//  MSVCanvasAbstractState.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasAbstractState.h"

@implementation MSVCanvasAbstractState


@synthesize touchBeginPos = _touchBeginPos;
@synthesize touchMovePos = _touchMovePos;

@synthesize canvasModel = _canvasModel;

-(instancetype) initWithCanvasModel:(MSVCanvasModel*) canvasModel
{
    self = [super init];
    
    if(self)
    {
        self.touchBeginPos = CGPointZero;
        self.touchMovePos = CGPointZero;
        self.canvasModel = canvasModel;
    }
    
    return self;
}

-(void) dealloc
{
}

- (void)touchesBeganInPos:(CGPoint) pos
{
    self.touchBeginPos = pos;
}

- (void)touchesMovedInPos:(CGPoint) pos
{
    self.touchMovePos = pos;
}

- (void)touchesEndedInPos:(CGPoint) pos
{
    self.touchBeginPos = CGPointZero;
    self.touchMovePos = CGPointZero;
}

- (void)touchesCancelledInPos:(CGPoint) pos
{
    self.touchBeginPos = CGPointZero;
    self.touchMovePos = CGPointZero;
}

-(void) drawSelection
{
    
}

@end
