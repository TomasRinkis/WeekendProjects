//
//  DMMoveState.m
//  DriskelMator
//
//  Created by Brolis on 5/2/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMMoveState.h"

#import "DMScreen.h"
#import "DMGraphics.h"
#import "DMCircleElement.h"
#import "DMCanvas.h"
#import <GLKit/GLKMatrix4.h>
#import <GLKit/GLKVector3.h>
#import "DMGeometryUtils.h"

@implementation DMMoveState

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
}

- (void)touchesMoved:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesMoved:touches inPos:pos];

    DMAbtractElement *selectedElement = [[self canvas] selectedElement];
    
    if(selectedElement && [selectedElement intersectsWithPoint:self.touchMovedPos])
    {
        GLKVector2 translate    = GLKVector2Subtract(self.touchMovedPos, self.touchBeginPos);
        self.touchBeginPos      = self.touchMovedPos;
        selectedElement.translation = GLKMatrix4Translate(selectedElement.translation, translate.x, translate.y, 0.f);
    }
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
    return [[DMMoveState alloc] initWithCanvas:canvas];
}

@end
