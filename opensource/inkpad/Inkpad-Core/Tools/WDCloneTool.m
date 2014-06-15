//
//  WDCloneTool.m
//  Inkpad
//
//  Created by Brolis on 6/15/14.
//  Copyright (c) 2014 Taptrix, Inc. All rights reserved.
//

#import "WDCloneTool.h"
#import "WDCanvasView.h"
#import "WDCanvasController.h"
#import "WDDrawingController.h"
#import "WDToolManager.h"

@implementation WDCloneTool

- (NSString *) iconName
{
    return @"duplicate.png";
}


- (void) beginWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas;
{

    
}

- (void) moveWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas
{

}

- (void) endWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas
{
    WDDrawingController *drawingController = canvas.controller.drawingController;
    
    BOOL hasSelection = drawingController.selectedObjects.count > 0 ? YES : NO;
    
    if(hasSelection)
    {
        [drawingController copy:nil];
        [drawingController paste:nil];
        [[WDToolManager sharedInstance] setActiveTool:[[WDToolManager sharedInstance] tools][0]];
    }
}


@end
