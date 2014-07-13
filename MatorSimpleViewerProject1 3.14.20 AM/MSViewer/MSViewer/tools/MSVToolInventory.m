//
//  MSVToolInventory.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVToolInventory.h"

#import "MSVSelectToolButton.h"
#import "MSVCropToolButton.h"
#import "MSVDeleteToolButton.h"

@implementation MSVToolInventory

@synthesize toolArray = _toolArray;

-(id) init
{
    self = [super init];
    
    if(self)
    {
        const int buttonHalfDimension   = [MSVAbstractToolButton halfDimension];
        
        MSVAbstractToolButton *selectTool   = [MSVSelectToolButton createWithFrame:CGRectMake(4.f, 20.f+ buttonHalfDimension * 0, buttonHalfDimension, buttonHalfDimension)];
        MSVAbstractToolButton *cropTool     = [MSVCropToolButton createWithFrame:CGRectMake(4.f, 20.f+ buttonHalfDimension * 1, buttonHalfDimension, buttonHalfDimension)];
        MSVAbstractToolButton *deleteTool   = [MSVDeleteToolButton createWithFrame:CGRectMake(4.f, 20.f+ buttonHalfDimension * 2, buttonHalfDimension, buttonHalfDimension)];
        
        /*
         DMAbsractTool *moveTool         = [DMMoveTool createWithFrame:CGRectMake(2.f, 10.f+ buttonHalfDimension * 1, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createMoveState]];
         DMAbsractTool *rotateTool       = [DMRotateTool createWithFrame:CGRectMake(2.f, 10.f+ buttonHalfDimension * 2, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createRotateState]];
         DMAbsractTool *rectangleTool    = [DMRectangleTool createWithFrame:CGRectMake(2.f, 10.f+ buttonHalfDimension * 3, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createRectangleState]];
         DMAbsractTool *ovalTool         = [DMOvalTool createWithFrame:CGRectMake(2.f, 10.f + buttonHalfDimension * 4, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createOvalState]];
         DMAbsractTool *pusherTool       = [DMPusherTool createWithFrame:CGRectMake(2.f, 10.f + buttonHalfDimension * 5, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createPusherState]];
         DMAbsractTool *trashTool        = [DMTrashTool createWithFrame:CGRectMake(2.f, 10.f + buttonHalfDimension * 6, buttonHalfDimension, buttonHalfDimension) andCanvasState:[DMCanvas createTrashState]];
         */
        //         _toolArray = @[selectTool, rotateTool, moveTool, rectangleTool, ovalTool, pusherTool, trashTool];
        _toolArray = @[selectTool, cropTool, deleteTool];
    }
    
    return self;
}

+(instancetype) sharedInstance
{
    static MSVToolInventory *toolInventory = NULL;
    
    if(!toolInventory)
    {
        toolInventory = [[MSVToolInventory alloc] init];
    }
    
    return toolInventory;
}

-(void) fillToolButtonsInView:(UIView*)view;
{
    for (MSVAbstractToolButton *toolButton in _toolArray)
    {
        [view addSubview:toolButton];
    }
}

-(void) unselectAllTools
{
    for (MSVAbstractToolButton *toolButton in _toolArray)
    {
        [toolButton releaseButton];
    }
}

@end
