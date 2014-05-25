//
//  DMCreateRectState.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMCreateRectState.h"
#import "DMScreen.h"
#import "DMGraphics.h"
#import "DMRectElement.h"
#import "DMCanvas.h"
#import "DMGeometryUtils.h"
#import <GLKit/GLKMatrix4.h>

@interface DMCreateRectState()
{
    CGRect  rectToMake;
}
@end


@implementation DMCreateRectState

-(id) initWithCanvas:(DMCanvas *)canvas
{
    self = [super initWithCanvas:canvas];
    
    if(self)
    {
        rectToMake      = CGRectZero;
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

   rectToMake = [DMGeometryUtils makeRect:self.touchBeginPos :self.touchMovedPos];
}

- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesEnded:touches inPos:pos];

    CGRect rect = CGRectMake(0.f, 0.f, rectToMake.size.width, rectToMake.size.height);
    GLKMatrix4 translation = GLKMatrix4MakeTranslation(rectToMake.origin.x, rectToMake.origin.y, 0.f);
    
    DMRectElement *rectElement = [DMRectElement createWithBounds:rect translation:translation andRotation:GLKMatrix4Identity];
    [[[self canvas] elementArray] addObject:rectElement];
    
    rectToMake      = CGRectZero;
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
    [DMGraphics drawRect:rectToMake trasform:GLKMatrix4Identity andColor: GLKVector3Make(0.f, 1.f, 0.f)];
}


+(DMCreateRectState*) createWithCanvas:(DMCanvas*) canvas
{
    return [[DMCreateRectState alloc] initWithCanvas:canvas];
}

@end
