//
//  WDTransformTool.m
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2009-2013 Steve Sprang
//

#import "WDCanvasView.h"
#import "WDDrawingController.h"
#import "WDTransformTool.h"

@implementation WDTransformTool

- (BOOL) needsPivot {
    return YES;
}

- (CGAffineTransform) computeTransform:(CGPoint)pt pivot:(CGPoint)pivot constrain:(WDToolFlags)flags
{
    return CGAffineTransformIdentity;
}

- (void) beginWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas
{
    // reset the transform
    transform_ = CGAffineTransformIdentity;
}

- (void) moveWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas
{
    canvas.transforming = YES;
    
    // transform selected
    transform_ = [self computeTransform:event.snappedLocation pivot:canvas.pivot constrain:self.flags];
    [canvas transformSelection:transform_];
}

- (void) endWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas
{
    if (self.moved) {
        // apply the transform to the drawing
        [canvas.drawingController transformSelection:transform_];
        [canvas transformSelection:CGAffineTransformIdentity];
        canvas.transforming = NO;
    } else {
        canvas.pivot = event.snappedLocation;
    }
    
    transform_ = CGAffineTransformIdentity;
}

- (void) flagsChangedInCanvas:(WDCanvasView *)canvas
{
    if (self.moved) {
        transform_ = [self computeTransform:self.previousEvent.snappedLocation pivot:canvas.pivot constrain:self.flags];
        [canvas transformSelection:transform_];
    }
}

@end
