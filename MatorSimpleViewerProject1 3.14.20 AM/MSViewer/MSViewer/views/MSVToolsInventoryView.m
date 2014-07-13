//
//  MSVToolsInventoryView.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVToolsInventoryView.h"
#import <GLKit/GLKit.h>

@interface MSVToolsInventoryView()
{
    GLKVector2 _touchBeginPoint;
    GLKVector2 _frameCenterOnTouchBeginPos;
}
@end

@implementation MSVToolsInventoryView

-(instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self)
    {
        self.multipleTouchEnabled       = YES;
        self.autoresizingMask           = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.contentMode                = UIViewContentModeCenter;
        self.exclusiveTouch             = YES;
        self.clearsContextBeforeDrawing = YES;
        self.userInteractionEnabled     = YES;
        self.backgroundColor            = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.5f];
        
        _touchBeginPoint                = GLKVector2Make(0.f, 0.f);
        _frameCenterOnTouchBeginPos     = GLKVector2Make(0.f, 0.f);
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    
    _touchBeginPoint      = GLKVector2Make(pos.x, pos.y);
    _frameCenterOnTouchBeginPos = GLKVector2Make(self.center.x, self.center.y);
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    
    GLKVector2 touchesDiffPoint = GLKVector2Subtract(GLKVector2Make(pos.x, pos.y), _touchBeginPoint);
    GLKVector2 centerPoint = GLKVector2Add(touchesDiffPoint, _frameCenterOnTouchBeginPos);
    
    self.center = CGPointMake(centerPoint.x, centerPoint.y);
    
    [self setNeedsDisplayInRect:self.frame];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchBeginPoint                = GLKVector2Make(0.f, 0.f);
    _frameCenterOnTouchBeginPos     = GLKVector2Make(0.f, 0.f);
    
}

+(instancetype) createWithFrame:(CGRect) frame
{
    return [[MSVToolsInventoryView alloc] initWithFrame:frame];
}

@end
