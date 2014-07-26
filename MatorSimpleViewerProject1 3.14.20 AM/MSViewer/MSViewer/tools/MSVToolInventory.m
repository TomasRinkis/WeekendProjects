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
#import "MSVZoomToolButton.h"

@implementation MSVToolInventory

@synthesize toolArray = _toolArray;

-(id) init
{
    self = [super init];
    
    if(self)
    {
        const int buttonHalfDimension   = [MSVAbstractToolButton halfDimension];
        
        MSVAbstractToolButton *selectTool   = [MSVSelectToolButton createWithFrame:CGRectMake(4.f, 20.f+ buttonHalfDimension * 0, buttonHalfDimension, buttonHalfDimension)];
//        MSVAbstractToolButton *cropTool     = [MSVCropToolButton createWithFrame:CGRectMake(4.f, 20.f+ buttonHalfDimension * 1, buttonHalfDimension, buttonHalfDimension)];
        MSVAbstractToolButton *deleteTool   = [MSVDeleteToolButton createWithFrame:CGRectMake(4.f, 20.f+ buttonHalfDimension * 1, buttonHalfDimension, buttonHalfDimension)];
        MSVAbstractToolButton *zoomTool     = [MSVZoomToolButton createWithFrame:CGRectMake(4.f, 20.f+ buttonHalfDimension * 2, buttonHalfDimension, buttonHalfDimension)];

        //<don't use crop at the moment
        _toolArray = @[selectTool, deleteTool, zoomTool];
    }
    
    return self;
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


-(void) pressButtonWithType:(MSVToolType) type
{
    [_toolArray[type] pressButton];
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
@end
