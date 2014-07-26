//
//  MSVScreen.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVScreen.h"


CGRect _screenBounds;
float _scale = 0.f;

@implementation MSVScreen

+(void) initWithScreenBounds:(CGRect) bounds
{
    _screenBounds = bounds;
    _scale = 1.f;
}

+(void) tearDown
{
    _screenBounds = CGRectZero;
    _scale = 1.f;
}

+(CGRect) screenBounds
{
    return _screenBounds;
}

+(void) setScale:(float) scale
{
    _scale = scale;
}

+(float) scale
{
    return _scale;
}

+(float) left
{
    return 0.f;
}

+(float) right
{
    return _screenBounds.size.width;
}

+(float) top
{
    return 0.f;
}

+(float) bot
{
    return _screenBounds.size.height;
}

+(float) height
{
    return _screenBounds.size.height;
}

+(float) width
{
    return _screenBounds.size.width;
}

+(float) halfHeight
{
    return [MSVScreen height]/2.f;
}

+(float) halfWidth
{
    return [MSVScreen width]/2.f;
}

+(float) fatFingerOffset
{
    return 70.f;
}

//normalized
+(float) leftNS
{
    return -[MSVScreen aspect];
}

+(float) rightNS
{
    return [MSVScreen aspect];
}

+(float) topNS
{
    return 1.f;
}

+(float) botNS
{
    return -1.f;
}

+(float) aspect
{
    return [MSVScreen width]/[MSVScreen height];
}

+(CGPoint) centerPoint
{
    return CGPointMake([MSVScreen halfWidth], [MSVScreen halfHeight]);
}

+(CGPoint) scaledPoint:(CGPoint) point
{
    CGAffineTransform transform = CGAffineTransformMakeScale(_scale, _scale);
    point = CGPointApplyAffineTransform(point, transform);
    
    return point; 
}

+(CGPoint) pointInNS:(CGPoint)p
{
    CGPoint ns;
    const float half_screen_wd = [MSVScreen halfWidth];
    const float half_screen_ht = [MSVScreen halfHeight];
    
    ns.x =[MSVScreen aspect] * ((p.x - half_screen_wd)/half_screen_wd);
    ns.y = -1.f * ((p.y - half_screen_ht)/half_screen_ht);
    
    return ns;
}

+(CGSize)  sizeInNS:(CGSize)size
{
    CGSize ns;
    const float screen_wd = [MSVScreen width];
    const float screen_ht = [MSVScreen height];
    const float aspect    = [MSVScreen aspect];
    const float magicNumber = 0.89f;
    
    ns.width = fabsf(size.width/(screen_wd * (aspect * magicNumber)));
    ns.height = fabsf(2.f * size.height/(screen_ht));
    
    return ns;
}


+(CGRect)  rectInNS:(CGRect) rect
{
    CGPoint nsOrigin = [MSVScreen pointInNS:rect.origin];
    CGSize  nsSize   = [MSVScreen sizeInNS:rect.size];    
    return CGRectMake(nsOrigin.x, nsOrigin.y, nsSize.width, nsSize.height);
}


+(CGPoint) convertToNS:(float) x : (float) y
{
    CGPoint ns;
    const float half_screen_wd = [MSVScreen halfWidth];
    const float half_screen_ht = [MSVScreen halfHeight];
    
    ns.x =[MSVScreen aspect] * ((x - half_screen_wd)/half_screen_wd);
    ns.y = -1.f * ((y - half_screen_ht)/half_screen_ht);
    
    return ns;
}

+(CGPoint) convertUITouchEventToNS:(UITouch *) touchEvent
{
    CGPoint pos = [touchEvent locationInView: [UIApplication sharedApplication].keyWindow];
    return [MSVScreen convertToNS:pos.x : pos.y];
}


+(CGSize) scaledSize:(CGSize) size
{
    CGAffineTransform transform = CGAffineTransformMakeScale(_scale, _scale);
    size = CGSizeApplyAffineTransform(size, transform);
    
    return size;
}

+(CGPoint) ciImageSpacePoint:(const CGPoint) point
{
    CGPoint ciImagePoint = CGPointZero;
    
    ciImagePoint.x = point.x;
    ciImagePoint.y = [MSVScreen height] - point.y;
    
    return ciImagePoint;
}

+(CGRect) makeRect:(CGPoint) posA :(CGPoint) posB
{
    GLKVector2 p1 = GLKVector2Make(posA.x, posA.y);
    GLKVector2 p2 = GLKVector2Make(posB.x, posB.y);
    
    GLKVector2 centerPos = GLKVector2Subtract(p2, p1);
    centerPos = GLKVector2DivideScalar(centerPos, 2.f);
    centerPos = GLKVector2Add(p1, centerPos);
    
    float width = ABS(posA.x - posB.x);
    float height = ABS(posA.y - posB.y);
    
    return CGRectMake(centerPos.x, centerPos.y, width, height);
}

@end
