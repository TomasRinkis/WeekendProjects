//
//  WDShadow.h
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2011-2013 Steve Sprang
//

#import <Foundation/Foundation.h>
#import "WDDrawing.h"

@class WDColor;
@class WDXMLElement;

/*
 Holds state of shadow for propably using Core Graphic rendering
 */
@interface WDShadow : NSObject <NSCoding, NSCopying>

@property (nonatomic, readonly) WDColor *color;
@property (nonatomic, readonly) float radius;
@property (nonatomic, readonly) float offset;
@property (nonatomic, readonly) float angle;

+ (instancetype) shadowWithColor:(WDColor *)color radius:(float)radius offset:(float)offset angle:(float)angle;
- (instancetype) initWithColor:(WDColor *)color radius:(float)radius offset:(float)offset angle:(float)angle;

- (void) applyInContext:(CGContextRef)ctx metaData:(WDRenderingMetaData)metaData;

- (instancetype) adjustColor:(WDColor * (^)(WDColor *color))adjustment;

- (void) addSVGAttributes:(WDXMLElement *)element;

@end
