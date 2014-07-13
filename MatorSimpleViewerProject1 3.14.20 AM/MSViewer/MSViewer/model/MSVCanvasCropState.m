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

#import <GLKit/GLKit.h>

@interface MSVCanvasCropState()
{
    CGRect _selectionRect;
}
@end

@implementation MSVCanvasCropState

-(instancetype) initWithCanvasModel:(MSVCanvasModel *)canvasModel
{
    self = [super initWithCanvasModel:canvasModel];
    
    if(self)
    {
        _selectionRect = CGRectZero;
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

    _selectionRect = [MSVScreen makeRect:self.touchBeginPos :pos];
}

- (void)touchesEndedInPos:(CGPoint) pos
{
    MSVCanvasImageElement *imageElement = (MSVCanvasImageElement*)self.canvasModel.selectedElement;
    
    if(imageElement)
    {
        CGPoint ciImagePos  = imageElement.pos;
        CGSize  ciImageSize = CGSizeMake(imageElement.size.width, imageElement.size.height);
        
        CGRect imageRect = CGRectMake(ciImagePos.x, ciImagePos.y - ciImageSize.height, ciImageSize.width, ciImageSize.height);
       
        CGRect selectRect = CGRectMake(
                             MIN(self.touchBeginPos.x, pos.x),
                              MIN(self.touchBeginPos.y, pos.y),
                              fabs(self.touchBeginPos.x - pos.x),
                              fabs(self.touchBeginPos.y - pos.y));
        
        CGRect intersectionRect =  CGRectIntersection(imageRect, selectRect);
        
        if(intersectionRect.size.width > 0)
        {
            CIImage *elementImage   = imageElement.image;
            
            CGPoint pIn = intersectionRect.origin;
            CGPoint pIm = imageRect.origin;
            
            CGRect cropImageRect    = CGRectMake(pIn.x - pIm.x, pIn.y - pIm.y, intersectionRect.size.width, intersectionRect.size.height);
            CIImage *cropedImage    = [elementImage imageByCroppingToRect:cropImageRect];
    
            MSVCanvasImageElement *imageElement = [MSVCanvasImageElement createWithCIImage:cropedImage atPos:CGPointMake(200.f, 200.f) withSize:intersectionRect.size];
            [self.canvasModel addElelemet:imageElement];
        }
    }
    
    _selectionRect = CGRectZero;
    [super touchesEndedInPos:pos];
}

- (void)touchesCancelledInPos:(CGPoint) pos
{
    [super touchesCancelledInPos:pos];
    _selectionRect = CGRectZero;
}

-(void) drawSelection
{
    CGPoint pos = [MSVScreen pointInNS:_selectionRect.origin];
    CGSize size = [MSVScreen sizeInNS:_selectionRect.size];
    
    //NSLog(@"%f", size.width);
    
    CGRect rect = CGRectMake(pos.x, pos.y, size.width, size.height);
    [MSVGraphics drawRect:rect andColor:GLKVector3Make(0.f, 1.f, 0.f)];
}

+(instancetype) createWithCanvasModel:(MSVCanvasModel*)canvasModel
{
    return [[MSVCanvasCropState alloc] initWithCanvasModel:canvasModel];
}

@end
