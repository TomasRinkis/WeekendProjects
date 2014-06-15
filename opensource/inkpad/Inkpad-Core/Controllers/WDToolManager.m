//
//  WDToolManager.m
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2011-2013 Steve Sprang
//

#import "WDAddAnchorTool.h"
#import "WDEyedropperTool.h"
#import "WDEraserTool.h"
#import "WDFreehandTool.h"
#import "WDPenTool.h"
#import "WDRotateTool.h"
#import "WDScaleTool.h"
#import "WDScissorTool.h"
#import "WDSelectionTool.h"
#import "WDShapeTool.h"
#import "WDTextTool.h"
#import "WDToolManager.h"

NSString *WDActiveToolDidChange = @"WDActiveToolDidChange";

@implementation WDToolManager

@synthesize activeTool = activeTool_;
@synthesize tools = tools_;

+ (instancetype) sharedInstance
{
    static WDToolManager *toolManager_ = nil;
    
    if (!toolManager_)
    {
        toolManager_ = [[WDToolManager alloc] init];
        toolManager_.activeTool = (toolManager_.tools)[0];
    }
    
    return toolManager_;
}

- (NSArray *) tools
{
    if (!tools_)
    {
        WDSelectionTool *groupSelect = (WDSelectionTool *) [WDSelectionTool create];
        groupSelect.groupSelect = YES;
        
        WDFreehandTool *closedFreehand = (WDFreehandTool *) [WDFreehandTool create];
        closedFreehand.closeShape = YES;
        
        WDShapeTool *oval = (WDShapeTool *) [WDShapeTool create];
        oval.shapeMode = WDShapeOval;
        
        WDShapeTool *rect = (WDShapeTool *) [WDShapeTool create];
        rect.shapeMode = WDShapeRectangle;
        
        WDShapeTool *star = (WDShapeTool *) [WDShapeTool create];
        star.shapeMode = WDShapeStar;
        
        WDShapeTool *poly = (WDShapeTool *) [WDShapeTool create];
        poly.shapeMode = WDShapePolygon;
        
        WDShapeTool *line = (WDShapeTool *) [WDShapeTool create];
        line.shapeMode = WDShapeLine;
        
        WDShapeTool *spiral = (WDShapeTool *) [WDShapeTool create];
        spiral.shapeMode = WDShapeSpiral;
        
        tools_ = @[[WDSelectionTool create],
                   groupSelect,
                   [WDPenTool create],
                   [WDAddAnchorTool create],
                   [WDScissorTool create],
                   @[[WDFreehandTool create], closedFreehand],
                   [WDEraserTool create],
                   @[rect, oval, star, poly, spiral, line],
                   [WDTextTool create],
                   [WDEyedropperTool create],
                   [WDScaleTool create],
                   [WDRotateTool create]];
    }
    
    return tools_;
}

- (void) setActiveTool:(WDGenericTool *)activeTool
{
    [activeTool_ deactivated];
    activeTool_ = activeTool;
    [activeTool_ activated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WDActiveToolDidChange object:nil userInfo:nil];
}

@end
