//
//  WDTool.m
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
#import "WDPickResult.h"
#import "WDTool.h"
#import "UIView+Additions.h"

#define kOptionsViewCornerRadius    9

@implementation WDEvent
@synthesize location;
@synthesize snappedLocation;
@synthesize count;
@end

@implementation WDTool

@synthesize primaryTouchEnded = primaryTouchEnded_;
@synthesize primaryTouch = primaryTouch_;
@synthesize moved = moved_;
@synthesize flags = flags_;
@synthesize initialEvent = initialEvent_;
@synthesize previousEvent = previousEvent_;

+ (WDTool *) tool
{
    return [[[self class] alloc] init];
}

- (NSString *) iconName
{
    return nil;
}

- (id) icon
{
#if TARGET_OS_IPHONE
    return [UIImage imageNamed:self.iconName];
#else
    return [NSImage imageNamed:self.iconName];
#endif
}

- (BOOL) createsObject
{
    return NO;
}

- (BOOL) needsPivot
{
    return NO;
}

- (UIView *) optionsView
{
    return nil;
}

- (void) configureOptionsView:(UIView *)options
{
    CALayer *layer = options.layer;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRoundedRect:options.bounds
                                                          cornerRadius:kOptionsViewCornerRadius];
    
    layer.shadowPath = shadowPath.CGPath;
    layer.cornerRadius = kOptionsViewCornerRadius;
    layer.shadowOpacity = 0.4f;
    layer.shadowRadius = 2;
    layer.shadowOffset = CGSizeZero;

    [options addParallaxEffect];
}

- (void) activated
{
}

- (void) deactivated
{
}

- (BOOL) isDefaultForKind
{
    return NO;
}

- (BOOL) shouldSnapPointsToGuides
{
    return NO;
}

- (CGPoint) snappedPointForPoint:(CGPoint)pt inCanvas:(WDCanvasView *)canvas
{
    NSUInteger snapFlags = [canvas.drawing snapFlags] | kWDSnapLocked | kWDSnapSubelement;
    
    if (self.shouldSnapPointsToGuides && canvas.drawing.dynamicGuides) {
        snapFlags |= kWDSnapDynamicGuides;
    }
    
    WDPickResult *result = [canvas.drawingController snappedPoint:pt viewScale:canvas.viewScale snapFlags:(int)snapFlags];
    
    return result.snapped ? result.snappedPoint : pt;
}

#pragma mark -
#pragma mark iOS Event Handling
#if TARGET_OS_IPHONE

- (WDEvent *) genericEventForTouch:(UITouch *)touch inCanvas:(WDCanvasView *)canvas
{
    WDEvent *event = [[WDEvent alloc] init];
    
    event.location = [canvas convertPointToDocumentSpace:[touch locationInView:canvas]];
    event.snappedLocation = [self snappedPointForPoint:event.location inCanvas:canvas];
    event.count = touch.tapCount;
    
    return event;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inCanvas:(WDCanvasView *)canvas
{
    if ([event allTouches].count == 1) {
        primaryTouch_ = [touches anyObject];
        
        primaryTouchEnded_ = NO;
        moved_ = NO;
        flags_ = WDToolDefault;
        
        // the primary touch has begun
        WDEvent *genericEvent = [self genericEventForTouch:primaryTouch_ inCanvas:canvas];
        
        self.initialEvent = genericEvent;
        [self beginWithEvent:genericEvent inCanvas:canvas];
        self.previousEvent = genericEvent;
    }
    
    // if the primary touch has ended, we're done caring
    if (self.primaryTouchEnded) {
        return;
    }
    
    if ([event allTouches].count > 1) {
        // if we have a new touch, we need to constrain
        flags_ = WDToolSecondaryTouch;
        [self flagsChangedInCanvas:canvas];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event inCanvas:(WDCanvasView *)canvas
{   
    if (self.primaryTouchEnded) {
        return;
    }
    
    WDEvent *genericEvent = [self genericEventForTouch:primaryTouch_ inCanvas:canvas];
    [self moveWithEvent:genericEvent inCanvas:canvas];
    self.previousEvent = genericEvent;
    
    moved_ = YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event inCanvas:(WDCanvasView *)canvas
{
    if (self.primaryTouchEnded) {
        return;
    }
    
    if ([touches containsObject:primaryTouch_]) {
        WDEvent *genericEvent = [self genericEventForTouch:primaryTouch_ inCanvas:canvas];
        [self endWithEvent:genericEvent inCanvas:canvas];

        self.initialEvent = nil;
        self.previousEvent = nil;
        
        primaryTouchEnded_ = YES;
        primaryTouch_ = nil;
    }
    
    if (!self.primaryTouchEnded) {
        // reflect the modifier touch immediately
        NSInteger   remainingTouchCount = [event allTouches].count - touches.count;
        WDToolFlags newFlags = (remainingTouchCount > 1 ? WDToolSecondaryTouch : WDToolDefault);
        
        [self setFlags:newFlags inCanvas:canvas];
        return;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event inCanvas:(WDCanvasView *)canvas
{
    [self touchesEnded:touches withEvent:event inCanvas:canvas];
}

#endif

#pragma mark -
#pragma mark iOS Event Handling
#if !TARGET_OS_IPHONE

- (WDToolFlags) flagsForEvent:(NSEvent *)theEvent
{
    WDToolFlags flags = WDToolDefault;
    
    if (theEvent.modifierFlags & NSShiftKeyMask) {
        flags |= WDToolShiftKey;
    }
    
    if (theEvent.modifierFlags & NSAlternateKeyMask) {
        flags |= WDToolOptionKey;
    }
    
    return flags;
}

- (WDEvent *) genericEventForEvent:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas
{
    WDEvent *genericEvent = [[WDEvent alloc] init];
    
    genericEvent.location = [canvas convertPointFromBase:[theEvent locationInWindow]];
    genericEvent.snappedLocation = [self snappedPointForPoint:genericEvent.location inCanvas:canvas];
    genericEvent.count = theEvent.clickCount;
    
    return [genericEvent autorelease];
}

- (void) mouseDown:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas
{
    moved_ = NO;
    flags_ = [self flagsForEvent:theEvent];
    
    // primary touch has begun
    WDEvent *genericEvent = [self genericEventForEvent:theEvent inCanvas:canvas];
    
    self.initialEvent = genericEvent;
    [self beginWithEvent:genericEvent inCanvas:canvas];
    self.previousEvent = genericEvent;
}

- (void) mouseDragged:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas
{
    WDEvent *genericEvent = [self genericEventForEvent:theEvent inCanvas:canvas];
    [self moveWithEvent:genericEvent inCanvas:canvas];
    self.previousEvent = genericEvent;

    moved_ = YES;
}

- (void) mouseUp:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas
{
    WDEvent *genericEvent = [self genericEventForEvent:theEvent inCanvas:canvas];
    [self endWithEvent:genericEvent inCanvas:canvas];

    self.initialEvent = nil;
    self.previousEvent = nil;
}

- (void) flagsChanged:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas
{
    [self setFlags:[self flagsForEvent:theEvent] inCanvas:canvas];
}

#endif

#pragma mark -
#pragma mark Generic Event Handling

- (void) setFlags:(WDToolFlags)flags inCanvas:(WDCanvasView *)canvas
{
    if (flags != flags_) {
        flags_ = flags;
        [self flagsChangedInCanvas:canvas];
    }
}

- (void) beginWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas
{
    // IMPLEMENTED BY SUBCLASS
}

- (void) moveWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas
{
    // IMPLEMENTED BY SUBCLASS
}

- (void) endWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas
{
    // IMPLEMENTED BY SUBCLASS
}

- (void) flagsChangedInCanvas:(WDCanvasView *)canvas
{
    // IMPLEMENTED BY SUBCLASS
}

- (void) buttonDoubleTapped
{

}

@end
