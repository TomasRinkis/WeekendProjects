//
//  DMRotateState.m
//  DriskelMator
//
//  Created by Brolis on 5/3/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMRotateState.h"

#import "DMScreen.h"
#import "DMGraphics.h"
#import "DMCircleElement.h"
#import "DMGeometryUtils.h"
#import "DMCanvas.h"
#import <GLKit/GLKMatrix4.h>
#import <GLKit/GLKVector3.h>

@interface DMRotateState()
{
    GLKVector2 _selectedElementCenterPos;
}
@end

@implementation DMRotateState

-(id) initWithCanvas:(DMCanvas *)canvas
{
    self = [super initWithCanvas:canvas];
    
    if(self)
    {
        _selectedElementCenterPos = GLKVector2Make(0.f, 0.f);
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
    
    if(selectedElement)
    {
        _selectedElementCenterPos   = [DMGeometryUtils posFromFromGLKMatrix4:selectedElement.translation];
        
        const GLKVector2 translate = GLKVector2Subtract(self.touchMovedPos, _selectedElementCenterPos);
        const float rotAngleFromTouch = atan2(translate.y, translate.x);
        
        selectedElement.rotation    =  GLKMatrix4MakeRotation(rotAngleFromTouch, 0.f, 0.f, 1.f);
    }
}

- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesEnded:touches inPos:pos];
    _selectedElementCenterPos = GLKVector2Make(0.f, 0.f);
}

- (void)touchesCancelled:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesCancelled:touches inPos:pos];
    _selectedElementCenterPos = GLKVector2Make(0.f, 0.f);
}

- (void)update
{
    
}

- (void)draw
{
    DMAbtractElement *selectedElement = [[self canvas] selectedElement];
    
    if(selectedElement)
    {
        [DMGraphics drawLineFrom:CGPointMake(_selectedElementCenterPos.x, _selectedElementCenterPos.y) : CGPointMake(self.touchMovedPos.x, self.touchMovedPos.y) andColor:GLKVector3Make(1.f, 0.f, 0.f)];
    }
}

+(instancetype) createWithCanvas:(DMCanvas*) canvas
{
    return [[DMRotateState alloc] initWithCanvas:canvas];
}

@end