//
//  MSVCanvasCropState.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasCropState.h"

#import "MSVCanvasModel.h"
#import "MSVCanvasAbstractElement.h"
#import "MSVCanvasImageElement.h"

#import "MSVGraphics.h"
#import "MSVScreen.h"
#import "MSVCrop.h"

#import <GLKit/GLKit.h>

@implementation MSVCanvasCropState

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
    MSVCanvasImageElement *element = self.canvasModel.selectedElement;
    
    if(element)
    {
        CGPoint pos = [MSVScreen pointInNS:element.pos];
        CGSize size = [MSVScreen sizeInNS:element.crop.size];
        
        CGRect rect = CGRectMake(pos.x + size.width/2.f, pos.y + size.height/2.f, size.width, size.height);
        [MSVGraphics drawRect:rect andColor:GLKVector3Make(0.f, 1.f, 0.f)];
    }
}

+(instancetype) createWithCanvasModel:(MSVCanvasModel*)canvasModel
{
    return [[MSVCanvasCropState alloc] initWithCanvasModel:canvasModel];
}

@end
