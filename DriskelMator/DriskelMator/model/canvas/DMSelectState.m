//
//  DMSelectState.m
//  DriskelMator
//
//  Created by Brolis on 5/2/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMSelectState.h"
#import "DMScreen.h"
#import "DMGraphics.h"
#import "DMCircleElement.h"
#import "DMCanvas.h"
#import <GLKit/GLKMatrix4.h>

@implementation DMSelectState

-(id) initWithCanvas:(DMCanvas *)canvas
{
    self = [super initWithCanvas:canvas];
    
    if(self)
    {
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesBegan:touches inPos:pos];
    
    [[self canvas] unselectAllElement];
    
    NSEnumerator *enumerator = [[[self canvas] elementArray] reverseObjectEnumerator];
    
    for (DMAbtractElement *element in enumerator)
    {
        if([element intersectsWithPoint:pos])
        {
            element.selected = true;
            [[self canvas] setSelectedElement:element];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesMoved:touches inPos:pos];
}

- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesEnded:touches inPos:pos];
}

- (void)touchesCancelled:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesCancelled:touches inPos:pos];
}

- (void)update
{
}

- (void)draw
{
}

+(instancetype) createWithCanvas:(DMCanvas*) canvas
{
    return [[DMSelectState alloc] initWithCanvas:canvas];
}

@end