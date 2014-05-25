//
//  DMToolsPalleteVIew.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMToolsPalleteVIew.h"

@interface DMToolsPalleteVIew()
{
    GLKVector2 _touchBeginPoint;
    GLKVector2 _frameCenterOnTouchBeginPos;
}
@end

@implementation DMToolsPalleteVIew

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    NSAssert(self, @"wrong init");
    
    _controllerDelegate     = NULL;
    
    self.multipleTouchEnabled       = YES;
    self.autoresizingMask           = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.contentMode                = UIViewContentModeCenter;
    self.exclusiveTouch             = YES;
    self.clearsContextBeforeDrawing = YES;
    self.userInteractionEnabled     = YES;
    self.backgroundColor            = [UIColor colorWithRed:0.f green:0.f blue:1.f alpha:0.5f];
    
    _touchBeginPoint                = GLKVector2Make(0.f, 0.f);
    _frameCenterOnTouchBeginPos     = GLKVector2Make(0.f, 0.f);
    
    return self;
}

+(instancetype) createWithFrame:(CGRect) rect
{
    return [[DMToolsPalleteVIew alloc] initWithFrame:rect];
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

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchBeginPoint                = GLKVector2Make(0.f, 0.f);
    _frameCenterOnTouchBeginPos     = GLKVector2Make(0.f, 0.f);

}

-(void) drawRect:(CGRect)rect
{
    
}

@end
