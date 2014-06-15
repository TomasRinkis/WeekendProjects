//
//  WDGenericTool.h
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2009-2013 Steve Sprang
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class WDCanvasView;
@class WDDrawing;

typedef enum {
    WDGenericToolDefault           = 0,
    WDGenericToolShiftKey          = 1 << 0,
    WDGenericToolOptionKey         = 1 << 1,
    WDGenericToolControlKey        = 1 << 2,
    WDGenericToolSecondaryTouch    = 1 << 3
} WDGenericToolFlags;

// Generic event object to abstract touches and clicks
@interface WDEvent : NSObject
@property (nonatomic, assign) CGPoint location; // coordinate in document space
@property (nonatomic, assign) CGPoint snappedLocation; // snapped coordinate in document space
@property (nonatomic, assign) NSUInteger count; // tap or click count
@end

@interface WDGenericTool : NSObject

@property (weak, nonatomic, readonly) id icon;
@property (weak, nonatomic, readonly) NSString *iconName;
@property (nonatomic, readonly) BOOL needsPivot;
@property (nonatomic, readonly) BOOL primaryTouchEnded;
@property (weak, nonatomic, readonly) UITouch *primaryTouch;
@property (nonatomic, readonly) BOOL moved;
@property (nonatomic, readonly) BOOL createsObject;
@property (weak, nonatomic, readonly) UIView *optionsView;

@property (nonatomic, strong) WDEvent *initialEvent;
@property (nonatomic, strong) WDEvent *previousEvent;
@property (nonatomic, readonly) WDGenericToolFlags flags;
@property (nonatomic, readonly) BOOL shouldSnapPointsToGuides;

+ (instancetype) create;
- (void) activated;
- (void) deactivated;
- (BOOL) isDefaultForKind;

// apply common options view settings (shadow, etc.)
- (void) configureOptionsView:(UIView *)options;

#if TARGET_OS_IPHONE
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event inCanvas:(WDCanvasView *)canvas;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event inCanvas:(WDCanvasView *)canvas;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event inCanvas:(WDCanvasView *)canvas;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event inCanvas:(WDCanvasView *)canvas;
#else
- (void) mouseDown:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas;
- (void) mouseDragged:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas;
- (void) mouseUp:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas;
- (void) flagsChanged:(NSEvent *)theEvent inCanvas:(WDCanvasView *)canvas;
#endif

// generic event handling code

- (void) beginWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas;
- (void) moveWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas;
- (void) endWithEvent:(WDEvent *)event inCanvas:(WDCanvasView *)canvas;

- (void) setFlags:(WDGenericToolFlags)flags inCanvas:(WDCanvasView *)canvas;
- (void) flagsChangedInCanvas:(WDCanvasView *)canvas;

- (void) buttonDoubleTapped;

// raw drawing coordinate -> snapped drawing coordinate
- (CGPoint) snappedPointForPoint:(CGPoint)pt inCanvas:(WDCanvasView *)canvas;

@end
