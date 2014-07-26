//
//  MSVCanvasZoomState.m
//  MSViewer
//
//  Created by Brolis on 7/23/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasZoomState.h"
#import "MSVCanvasModel.h"
#import "MSVCanvasAbstractElement.h"


@implementation MSVCanvasZoomState

-(instancetype) initWithCanvasModel:(MSVCanvasModel *)canvasModel
{
    self = [super initWithCanvasModel:canvasModel];
    
    if(self)
    {
    }
    
    return self;
}

- (void)touchesBeganInPos:(CGPoint) pos
{
    [super touchesBeganInPos:pos];
}

- (void)touchesMovedInPos:(CGPoint) pos
{
    [super touchesMovedInPos:pos];
}

- (void)touchesEndedInPos:(CGPoint) pos
{
    [super touchesEndedInPos:pos];
    
}

- (void)touchesCancelledInPos:(CGPoint) pos
{
    [super touchesCancelledInPos:pos];
    
}

-(void) drawSelection
{
}

+(instancetype) createWithCanvasModel:(MSVCanvasModel*)canvasModel
{
    return [[MSVCanvasZoomState alloc] initWithCanvasModel:canvasModel];
}

@end