//
//  MSVCanvasSelectState.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasSelectState.h"
#import "MSVCanvasModel.h"
#import "MSVCanvasAbstractElement.h"
#import "MSVScreen.h"
#import "MSVGraphics.h"


#import <GLKit/GLKit.h>


@interface MSVCanvasSelectState()
{
    CGPoint prevMovePos;
}
@end

@implementation MSVCanvasSelectState

-(instancetype) initWithCanvasModel:(MSVCanvasModel *)canvasModel
{
    self = [super initWithCanvasModel:canvasModel];
    
    if(self)
    {
        prevMovePos = CGPointZero;
    }
    
    return self;
}

- (void)touchesBeganInPos:(CGPoint) pos
{
    [super touchesBeganInPos:pos];

    prevMovePos = pos;
    
    NSEnumerator *enumerator = [[self.canvasModel elementArray] reverseObjectEnumerator];
    
    [self.canvasModel unselectAllElements];
    
    for (MSVCanvasAbstractElement *element in enumerator)
    {
        if([element intersectsInPos:pos])
        {
            element.selected = true;
            self.canvasModel.selectedElement = element;
            
            NSLog(@"Colision detected");
        }
    }
}

- (void)touchesMovedInPos:(CGPoint) pos
{
    [super touchesMovedInPos:pos];

    MSVCanvasAbstractElement *selectedElement = self.canvasModel.selectedElement;
    
    if(selectedElement)
    {
        CGPoint elementPos = selectedElement.pos;
        elementPos.x += pos.x - prevMovePos.x;
        elementPos.y += pos.y - prevMovePos.y;
        
        selectedElement.pos = elementPos;
    }
    
    prevMovePos = pos;
}

- (void)touchesEndedInPos:(CGPoint) pos
{
    [super touchesEndedInPos:pos];

    prevMovePos = CGPointZero;
}

- (void)touchesCancelledInPos:(CGPoint) pos
{
    [super touchesCancelledInPos:pos];

    prevMovePos = CGPointZero;
}

-(void) drawSelection
{
    const CGSize fatFingerSize = CGSizeMake([MSVScreen fatFingerOffset], [MSVScreen fatFingerOffset]);
    const CGRect selectionRect = CGRectMake(self.touchMovePos.x + fatFingerSize.width/2, self.touchMovePos.y - fatFingerSize.height/2, fatFingerSize.width, fatFingerSize.height);
    const CGRect nsSelectionRect = [MSVScreen rectInNS:selectionRect];
    [MSVGraphics drawRect:nsSelectionRect andColor:GLKVector3Make(1.f, 0.f, 0.f)];
}

+(instancetype) createWithCanvasModel:(MSVCanvasModel*)canvasModel
{
    return [[MSVCanvasSelectState alloc] initWithCanvasModel:canvasModel];
}

@end
