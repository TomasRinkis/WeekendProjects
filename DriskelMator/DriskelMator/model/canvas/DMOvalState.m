//
//  DMOvalState.m
//  DriskelMator
//
//  Created by Brolis on 5/2/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMOvalState.h"

#import "DMScreen.h"
#import "DMGraphics.h"
#import "DMCircleElement.h"
#import "DMCanvas.h"
#import "DMGeometryUtils.h"
#import <GLKit/GLKMatrix4.h>
#import <GLKit/GLKVector3.h>

@interface DMOvalState()
{
    CGRect  rectToMake;
    bool    wasMovedTouchHack;
}
@end


@implementation DMOvalState

-(id) initWithCanvas:(DMCanvas *)canvas
{
    self = [super initWithCanvas:canvas];
    
    if(self)
    {
        rectToMake      = CGRectZero;
        wasMovedTouchHack = false;
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches inPos:(GLKVector2) pos
{
    wasMovedTouchHack = false;
    
    [super touchesBegan:touches inPos:pos];
}

- (void)touchesMoved:(NSSet *)touches inPos:(GLKVector2) pos
{
    wasMovedTouchHack = true;
    [super touchesMoved:touches inPos:pos];
    
    rectToMake = [DMGeometryUtils makeRect:self.touchBeginPos :self.touchMovedPos];
}

- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos
{
    float distance = GLKVector2Distance(pos, self.touchBeginPos);
    
    CGRect rect = CGRectMake(0.f, 0.f, distance, distance);
    GLKMatrix4 translation = GLKMatrix4MakeTranslation(self.touchBeginPos.x, self.touchBeginPos.y, 0.f);
    
    DMCircleElement *circElement = [DMCircleElement createWithBounds:rect translation:translation andRotation:GLKMatrix4Identity];
    [[[self canvas] elementArray] addObject:circElement];
    
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
    if(wasMovedTouchHack)
    {
        const float distance = GLKVector2Distance(self.touchMovedPos, self.touchBeginPos);
        GLKVector2 center = self.touchBeginPos;
        
        [DMGraphics drawCircleAt:center withRadius:distance andTrasform:GLKMatrix4Identity andColor:GLKVector3Make(0.f, 1.f, 0.f)];
    }
}


+(instancetype) createWithCanvas:(DMCanvas*) canvas
{
    return [[DMOvalState alloc] initWithCanvas:canvas];
}

@end
