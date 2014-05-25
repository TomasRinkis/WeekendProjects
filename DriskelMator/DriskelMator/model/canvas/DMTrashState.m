//
//  DMTrashState.m
//  DriskelMator
//
//  Created by Brolis on 5/3/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMTrashState.h"

#import "DMScreen.h"
#import "DMGraphics.h"
#import "DMCircleElement.h"
#import "DMCanvas.h"
#import "DMGeometryUtils.h"
#import <GLKit/GLKMatrix4.h>
#import <GLKit/GLKVector3.h>

@implementation DMTrashState

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
    
    DMAbtractElement *selectedElement = [[self canvas] selectedElement];
    
    if(selectedElement)
    {
        [[[self canvas] elementArray] removeObject:selectedElement];
        selectedElement = NULL;
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
    return [[DMTrashState alloc] initWithCanvas:canvas];
}

@end