//
//  WDSVGParserState.h
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Original implementation by Scott Vachalek
//
//  Copyright (c) 2011-2013 Steve Sprang
//

#import <Foundation/Foundation.h>
#import "WDAbstractElement.h"
#import "WDSVGElement.h"

@interface WDSVGParserState : NSObject {
    WDSVGElement        *svgElement_;
    WDAbstractElement           *wdElement_;
    NSMutableArray      *group_;
    CGAffineTransform   transform_;
    CGAffineTransform   viewBoxTransform_;
    CGRect              viewport_;
}

@property (nonatomic, readonly) WDSVGElement *svgElement;
@property (nonatomic, strong) WDAbstractElement *wdElement;
@property (nonatomic, readonly) NSMutableArray *group;
@property (nonatomic, assign) CGAffineTransform transform;
@property (nonatomic, assign) CGAffineTransform viewBoxTransform;
@property (nonatomic, assign) CGRect viewport;

- (id) initWithElement:(WDSVGElement *)element;

@end
