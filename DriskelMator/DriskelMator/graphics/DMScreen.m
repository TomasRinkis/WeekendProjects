//
//  DMScreen.m
//  DriskelMator
//
//  Created by Brolis on 4/14/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMScreen.h"

CGRect _screenBounds;

@implementation DMScreen


+(void) initWithScreenBounds:(CGRect) bounds
{
    _screenBounds = bounds;
}

+(void) tearDown
{
    _screenBounds = CGRectZero;
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
    return [DMScreen height]/2.f;
}

+(float) halfWidth
{
    return [DMScreen width]/2.f;
}

+(float) aspectRatio
{
    return _screenBounds.size.width / _screenBounds.size.height;
}

+(GLKVector2) resolution
{
    return GLKVector2Make(_screenBounds.size.width, _screenBounds.size.height);
}

+(GLKVector2) convertToNS:(float) x :(float) y;
{
    GLKVector2 ns;
    const float half_screen_wd = [DMScreen halfWidth];
    const float half_screen_ht = [DMScreen halfHeight];
    
    ns.x =[DMScreen aspectRatio] * ((x - half_screen_wd)/half_screen_wd);
    ns.y = -1.f * ((y - half_screen_ht)/half_screen_ht);
    
    return ns;
}


+(GLKVector2) convertUITouchEventToNS:(UITouch *) touchEvent
{
    CGPoint pos = [touchEvent locationInView: [UIApplication sharedApplication].keyWindow];
    
    return [DMScreen convertToNS:pos.x : pos.y];
}

+(float) fatFingerOffset
{
    return 0.1f;
}

//normalized
+(float) leftNS
{
    return -[DMScreen aspectRatio];
}

+(float) rightNS
{
    return [DMScreen aspectRatio];
}

+(float) topNS
{
    return 1.f;
}

+(float) botNS
{
    return -1.f;
}

@end
