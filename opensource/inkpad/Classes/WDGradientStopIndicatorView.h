//
//  WDGradientStopIndicatorView.h
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2010-2013 Steve Sprang
//

#import <UIKit/UIKit.h>

@class WDGradientStop;
@class WDGradientStopIndicatorView;

@interface WDGradientStopOverlayView : UIView
@property (nonatomic, weak) WDGradientStopIndicatorView *indicator;
@end

@interface WDGradientStopIndicatorView : UIView

@property (nonatomic, strong) WDGradientStop *stop;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, strong) WDGradientStopOverlayView *overlay;

- (id) initWithStop:(WDGradientStop *)stop;
- (CGRect) colorRect;

@end
