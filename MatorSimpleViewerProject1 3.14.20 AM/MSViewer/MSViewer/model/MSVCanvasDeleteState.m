//
//  MSVCanvasDeleteState.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasDeleteState.h"
#import "MSVCanvasModel.h"
#import "MSVCanvasAbstractElement.h"


@implementation MSVCanvasDeleteState

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
    
    NSEnumerator *enumerator = [[self.canvasModel elementArray] reverseObjectEnumerator];
    
    [self.canvasModel unselectAllElements];
    
    for (MSVCanvasAbstractElement *element in enumerator)
    {
        if([element intersectsInPos:pos])
        {
            [self.canvasModel deleteElement:element];
        }
    }
}

- (void)touchesMovedInPos:(CGPoint) pos
{
    [super touchesMovedInPos:pos];
    
    MSVCanvasAbstractElement *selectedElement = self.canvasModel.selectedElement;
    
    if(selectedElement)
    {
        //<move selected element
        selectedElement.pos = pos;
    }
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
    return [[MSVCanvasDeleteState alloc] initWithCanvasModel:canvasModel];
}

@end
