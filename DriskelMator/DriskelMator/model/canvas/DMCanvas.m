//
//  DMCanvas.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <GLKit/GLKMatrix4.h>


#import "DMCanvas.h"
#import "DMNotifications.h"
#import "DMShaderContainer.h"
#import "DMShaderConstants.h"
#import "DMShaderProgram.h"
#import "DMGraphics.h"
#import "DMGeometryUtils.h"
#import "DMScreen.h"

#import "DMCreateRectState.h"
#import "DMAbtractElement.h"
#import "DMRectElement.h"
#import "DMCreateRectState.h"
#import "DMOvalState.h"
#import "DMSelectState.h"
#import "DMMoveTool.h"
#import "DMMoveState.h"
#import "DMRotateState.h"
#import "DMPusherState.h"
#import "DMTrashState.h"

@implementation DMCanvas

@synthesize state = _state;
@synthesize elementArray = _elementArray;
@synthesize selectedElement = _selectedElement;
@synthesize background = _background;


static DMCanvas *canvas = NULL;

+(DMCanvas*) sharedInstance
{
    if(!canvas)
    {
        canvas = [[DMCanvas alloc] init];
    }
    
    return canvas;
}

-(id) init
{
    self = [super self];
    
    if(self)
    {
        _state              = [DMSelectState createWithCanvas:self];
        
        _elementArray       = [[NSMutableArray alloc] init];
        _selectedElement    = NULL;
        _background         = GLKVector4Make(0, 0, 0, 0);
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleSelectStateNotification:) name:DMSelectStateNotification object:nil];
        
    }
    
    return self;
}

- (void)touchesBegan:(NSSet *)touches inPos:(GLKVector2) pos
{
    [self.state touchesBegan:touches inPos:pos];
}

- (void)touchesMoved:(NSSet *)touches inPos:(GLKVector2) pos
{
    [self.state touchesMoved:touches inPos:pos];
}

- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos
{
    [self.state touchesEnded:touches inPos:pos];
}

- (void)touchesCancelled:(NSSet *)touches inPos:(GLKVector2) pos
{
    [self.state touchesCancelled:touches inPos:pos];
}

- (void)update
{
    [self.state update];
}

-(void) drawElements
{
    DMShaderProgram *primitiveShader =  [[DMShaderContainer sharedInstance] getShaderProgramFromName:[DMShaderConstants primitiveShaderName]];
    [DMGraphics setShaderProgram:primitiveShader];
    
    
    for (DMAbtractElement *element in _elementArray)
    {
        [element draw];
    }
}

-(void) unselectAllElement
{
    for (DMAbtractElement *element in _elementArray)
    {
        element.selected = FALSE;
    }
}

-(void) drawBackground
{
    DMShaderProgram *backgroundShader =  [[DMShaderContainer sharedInstance] getShaderProgramFromName:[DMShaderConstants backgroundShaderName]];
    [DMGraphics setShaderProgram:backgroundShader];
    [DMGraphics drawbackgroundWithColor:self.background];
}

- (void)draw
{
    [self drawBackground];
    [self drawElements];
    [self.state draw];
}

-(void) handleSelectStateNotification:(NSNotification *)aNotification
{
    
}

+(DMAbstarctState*) createRectangleState
{
    return [[DMCreateRectState alloc] initWithCanvas:canvas];
}


+(DMAbstarctState*) createOvalState
{
    return [[DMOvalState alloc] initWithCanvas:canvas];
}

+(DMAbstarctState*) createSelectState
{
    return [[DMSelectState alloc] initWithCanvas:canvas];
}

+(DMAbstarctState*) createMoveState
{
    return [[DMMoveState alloc] initWithCanvas:canvas];
}

+(DMAbstarctState*) createRotateState
{
    return [[DMRotateState alloc] initWithCanvas:canvas];
}

+(DMAbstarctState*) createPusherState
{
    return [[DMPusherState alloc] initWithCanvas:canvas];
}

+(DMAbstarctState*) createTrashState
{
    return [[DMTrashState alloc] initWithCanvas:canvas];
}

@end
