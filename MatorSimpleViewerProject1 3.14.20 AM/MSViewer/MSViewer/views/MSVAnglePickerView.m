//
//  MSVAnglePickerView.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVAnglePickerView.h"

const float kArrowInset = 5;
const float kArrowDimension = 6;


@interface MSVAnglePickerView()
{
    float           _initialValue;
    CGPoint         _initialTap;
}
@end

@implementation MSVAnglePickerView

@synthesize value = _value;

static inline CGPoint WDCenterOfRect(CGRect rect)
{
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

static inline CGPoint WDSubtractPoints(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x - b.x, a.y - b.y);
}

- (void) awakeFromNib
{
    self.exclusiveTouch = YES;
    
    self.layer.shadowOpacity = 0.15f;
    self.layer.shadowRadius = 2;
    self.layer.shadowOffset = CGSizeMake(0, 2);
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect rect = CGRectInset(self.bounds, 1, 1);
    CGPathAddEllipseInRect(pathRef, NULL, rect);
    self.layer.shadowPath = pathRef;
    CGPathRelease(pathRef);
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef    ctx = UIGraphicsGetCurrentContext();
    float           radius = CGRectGetWidth(self.bounds) / 2 - kArrowInset;
    CGPoint         center = WDCenterOfRect(self.bounds);
    CGRect          ellipseRect = CGRectInset(self.bounds, 1, 1);
    
    [[UIColor whiteColor] set];
    CGContextFillEllipseInRect(ctx, ellipseRect);
    
    [[UIColor lightGrayColor] set];
    CGContextSetLineWidth(ctx, 1.0 / [UIScreen mainScreen].scale);
    CGContextStrokeEllipseInRect(ctx, ellipseRect);
    
    CGContextSaveGState(ctx);
    
    [[UIColor colorWithRed:0.0f green:(118.0f / 255.0f) blue:1.0f alpha:1.0f] set];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineWidth(ctx, 2.0f);
    
    CGContextTranslateCTM(ctx, center.x, center.y);
    CGContextRotateCTM(ctx, _value);
    
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, radius - 0.5f, 0);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, radius - kArrowDimension, kArrowDimension);
    CGContextAddLineToPoint(ctx, radius, 0);
    CGContextAddLineToPoint(ctx, radius - kArrowDimension, -kArrowDimension);
    CGContextStrokePath(ctx);
    
    CGContextRestoreGState(ctx);
}

- (void) setValue:(float)value
{
    _value = value;
    [self setNeedsDisplay];
}

- (BOOL) beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    _initialValue = _value;
    _initialTap = [touch locationInView:self];
    
    return [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL) continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint     pt = [touch locationInView:self];
    CGPoint     pivot = WDCenterOfRect(self.bounds);
    CGPoint     delta = WDSubtractPoints(_initialTap, pivot);
    
    double offsetAngle = atan2(delta.y, delta.x);
    
    delta = WDSubtractPoints(pt, pivot);
    double angle = atan2(delta.y, delta.x);
    double diff = angle - offsetAngle;
    
    self.value = fmod(_initialValue + diff, M_PI * 2);
    
    return [super continueTrackingWithTouch:touch withEvent:event];
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self sendActionsForControlEvents:UIControlEventValueChanged];
    [super endTrackingWithTouch:touch withEvent:event];
}

@end
