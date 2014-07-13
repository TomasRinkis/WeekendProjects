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


@implementation MSVCanvasSelectState

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
    return [[MSVCanvasSelectState alloc] initWithCanvasModel:canvasModel];
}

@end
