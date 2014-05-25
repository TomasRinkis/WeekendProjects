//
//  DMToolInventory.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMToolInventory.h"
#import "DMRectangleTool.h"
#import "DMOvalTool.h"
#import "DMOvalState.h"
#import "DMSelectState.h"
#import "DMSelectTool.h"
#import "DMMoveTool.h"
#import "DMRotateTool.h"
#import "DMMoveState.h"
#import "DMCanvas.h"
#import "DMPusherTool.h"
#import "DMTrashTool.h"

@implementation DMToolInventory

@synthesize toolArray = _toolArray;

-(id) init
{
    self = [super init];
    
    if(self)
    {
        const int buttonHalfDimension   = [DMAbsractTool halfDimension];
        
        DMAbsractTool *selectTool       = [DMSelectTool createWithFrame:CGRectMake(2.f, 10.f, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createSelectState]];
        DMAbsractTool *moveTool         = [DMMoveTool createWithFrame:CGRectMake(2.f, 10.f+ buttonHalfDimension * 1, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createMoveState]];
        DMAbsractTool *rotateTool       = [DMRotateTool createWithFrame:CGRectMake(2.f, 10.f+ buttonHalfDimension * 2, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createRotateState]];
        DMAbsractTool *rectangleTool    = [DMRectangleTool createWithFrame:CGRectMake(2.f, 10.f+ buttonHalfDimension * 3, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createRectangleState]];
        DMAbsractTool *ovalTool         = [DMOvalTool createWithFrame:CGRectMake(2.f, 10.f + buttonHalfDimension * 4, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createOvalState]];
        DMAbsractTool *pusherTool       = [DMPusherTool createWithFrame:CGRectMake(2.f, 10.f + buttonHalfDimension * 5, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createPusherState]];
        DMAbsractTool *trashTool        = [DMTrashTool createWithFrame:CGRectMake(2.f, 10.f + buttonHalfDimension * 6, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createTrashState]];
        
        _toolArray = @[selectTool, rotateTool, moveTool, rectangleTool, ovalTool, pusherTool, trashTool];
    }
    
    return self;
}

+(instancetype) sharedInstance
{
    static DMToolInventory *toolInventory = NULL;
    
    if(!toolInventory)
    {
        toolInventory = [[DMToolInventory alloc] init];
    }
    
    return toolInventory;
}

-(void) fillView:(UIView*)view;
{
    for (DMAbsractTool *toolButton in _toolArray)
    {
        [view addSubview:toolButton];
    }
}

-(void) unselectAllTools
{
    for (DMAbsractTool *toolButton in _toolArray)
    {
        [toolButton buttonReleased];
    }
}

@end
