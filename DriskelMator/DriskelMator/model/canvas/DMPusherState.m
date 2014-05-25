//
//  DMPusherState.m
//  DriskelMator
//
//  Created by Brolis on 5/3/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMPusherState.h"

#import "DMScreen.h"
#import "DMGraphics.h"
#import "DMAbtractElement.h"
#import "DMCanvas.h"
#import "DMGeometryUtils.h"
#import <GLKit/GLKMatrix4.h>
#import <GLKit/GLKVector3.h>

@implementation DMPusherState

-(id) initWithCanvas:(DMCanvas*) canvas
{
    self = [super initWithCanvas:canvas];
    
    if(self)
    {
    }
    
    return self;
}

-(void) moveElementsLeft:(NSMutableArray*)elements by:(GLKVector2) pos
{
    for(DMAbtractElement *element in elements)
    {
        element.translation = GLKMatrix4Translate(element.translation, pos.x, 0.f, 0.f);
    }
}

-(void) moveElementsRight:(NSMutableArray*)elements by:(GLKVector2) pos
{
    for(DMAbtractElement *element in elements)
    {
        element.translation = GLKMatrix4Translate(element.translation, pos.x, 0.f, 0.f);
    }
}

-(void) moveElementsUp:(NSMutableArray*)elements by:(GLKVector2) pos
{
    for(DMAbtractElement *element in elements)
    {
        element.translation = GLKMatrix4Translate(element.translation, 0.f, pos.y, 0.f);
    }
}

-(void) moveElementsDown:(NSMutableArray*)elements by:(GLKVector2) pos
{
    for(DMAbtractElement *element in elements)
    {
        element.translation = GLKMatrix4Translate(element.translation, 0.f, pos.y, 0.f);
    }
}

- (void)touchesBegan:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesBegan:touches inPos:pos];
    self.moveDirectionState = DirectionNoneFlag;
}

-(void) defineMoveDirectionState
{
    if(self.moveDirectionState == DirectionNoneFlag)
    {
        GLKVector2 translate = GLKVector2Subtract(self.touchMovedPos, self.touchBeginPos);
        const float directionDetectionOffset = 0.02f;
        
        if(translate.x < -directionDetectionOffset)
        {
            self.moveDirectionState = DirectionLeftFlag;
            self.selectedElements = [super getRightSideElementsFromPos:self.touchMovedPos];
        }
        else if (translate.x > directionDetectionOffset)
        {
            self.moveDirectionState = DirctionRightFlag;
            self.selectedElements = [super getLeftSideElementsFromPos:self.touchMovedPos];
        }
        else if (translate.y > directionDetectionOffset)
        {
            self.moveDirectionState = DirectionUpFlag;
            self.selectedElements = [super getBotSideElementsFromPos:self.touchMovedPos];
        }
        else if (translate.y < -directionDetectionOffset)
        {
            self.moveDirectionState = DirectionDownFlag;
            self.selectedElements = [super getTopSideElementsFromPos:self.touchMovedPos];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesMoved:touches inPos:pos];
    GLKVector2 translate    = GLKVector2Subtract(self.touchMovedPos, self.touchBeginPos);
    
    [self defineMoveDirectionState];
    
    switch (self.moveDirectionState)
    {
        case DirectionLeftFlag:
        {
            [self moveElementsLeft:self.selectedElements by:translate];
        }
            break;
        case DirctionRightFlag:
        {
            [self moveElementsRight:self.selectedElements by:translate];
        }
            break;
        case DirectionUpFlag:
        {
            [self moveElementsUp:self.selectedElements by:translate];
        }
            break;
        case DirectionDownFlag:
        {
            [self moveElementsDown:self.selectedElements by:translate];
        }
            break;
        default:
            break;
    }
    
    self.touchBeginPos = self.touchMovedPos;
}

- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesEnded:touches inPos:pos];
    self.moveDirectionState = DirectionNoneFlag;
}

- (void)touchesCancelled:(NSSet *)touches inPos:(GLKVector2) pos
{
    [super touchesCancelled:touches inPos:pos];
    self.moveDirectionState = DirectionNoneFlag;
}

- (void)update
{
}

- (void)draw
{
    switch (self.moveDirectionState)
    {
        case DirctionRightFlag:
        case DirectionLeftFlag:
        {
            GLKVector2 from = GLKVector2Make(self.touchMovedPos.x, -1.f);
            GLKVector2 to   = GLKVector2Make(self.touchMovedPos.x, 1.f);
            [DMGraphics drawLineFrom:CGPointMake(from.x, from.y) :CGPointMake(to.x, to.y)  andColor:GLKVector3Make(0.f, 1.f, 0.f)];
        }
            break;
        case DirectionDownFlag:
        case DirectionUpFlag:
        {
            GLKVector2 from = GLKVector2Make(-1.f, self.touchMovedPos.y);
            GLKVector2 to   = GLKVector2Make(1.f, self.touchMovedPos.y);
            [DMGraphics drawLineFrom:CGPointMake(from.x, from.y) :CGPointMake(to.x, to.y)  andColor:GLKVector3Make(0.f, 1.f, 0.f)];
            
        }
            break;
        default:
            break;
    }
}

+(instancetype) createWithCanvas:(DMCanvas*) canvas
{
    return [[DMPusherState alloc] initWithCanvas:canvas];
}

@end
