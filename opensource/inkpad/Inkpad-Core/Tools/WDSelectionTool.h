//
//  WDSelectionTool.h
//  Inkpad
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.
//
//  Copyright (c) 2011-2013 Steve Sprang
//

#import "WDGenericTool.h"
#import "WDText.h"

@class WDBezierNode;
@class WDTextPathElement;

@interface WDSelectionTool : WDGenericTool {
    CGAffineTransform       transform_;
    BOOL                    marqueeMode_;
    BOOL                    groupSelect_;
    
    WDBezierNode            *activeNode_;
    NSUInteger              activeTextHandle_;
    NSUInteger              activeGradientHandle_;
    
    BOOL                    transformingGradient_;
    BOOL                    transformingNodes_;
    BOOL                    transformingHandles_;
    BOOL                    convertingNode_;
    BOOL                    transformingTextKnobs_;
    BOOL                    transformingTextPathStartKnob_;
    
    WDTextPathElement              *activeTextPath_;
    
    int                     originalReflectionMode_;
    WDBezierNode            *replacementNode_;
    NSUInteger              pointToMove_;
    NSUInteger              pointToConvert_;

    BOOL                    nodeWasSelected_;
    BOOL                    objectWasSelected_;
    WDAbstractElement               *lastTappedObject_;
}

@property (nonatomic, assign) BOOL groupSelect;

- (NSValue *) snapCorner:(CGPoint)pt inCanvas:(WDCanvasView *)canvas;
- (CGPoint) offsetSelection:(CGPoint)originalDelta inCanvas:(WDCanvasView *)canvas;

@end
