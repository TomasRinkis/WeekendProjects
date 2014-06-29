//
//  WDPathPainterProtocol.h
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2010-2013 Steve Sprang
//

#import <Foundation/Foundation.h>
#import "WDTextRendererProtocol.h"

@class WDAbstractPathElement;
@class WDColor;

@protocol WDPathPainterProtocol <NSObject>

@required
- (void) paintPath:(WDAbstractPathElement *)path inContext:(CGContextRef)ctx;
- (BOOL) transformable;
- (BOOL) wantsCenteredFillTransform;
- (BOOL) canPaintStroke;
- (void) drawSwatchInRect:(CGRect)rect;
- (void) drawEyedropperSwatchInRect:(CGRect)rect;
- (void) paintText:(id<WDTextRendererProtocol>)text inContext:(CGContextRef)ctx;
- (id) adjustColor:(WDColor * (^)(WDColor *color))adjustment;
@end
