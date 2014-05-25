//
//  DMScreen.h
//  DriskelMator
//
//  Created by Brolis on 4/14/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKVector2.h>

@interface DMScreen : NSObject

+(void) initWithScreenBounds:(CGRect) bounds;
+(void) tearDown;

+(float) left;
+(float) right;
+(float) top;
+(float) bot;
+(float) height;
+(float) width;
+(float) halfHeight;
+(float) halfWidth;

+(float) aspectRatio;
+(GLKVector2) resolution;

//normalized
+(float) leftNS;
+(float) rightNS;
+(float) topNS;
+(float) botNS;


+(GLKVector2) convertToNS:(float) x :(float) y;
+(GLKVector2) convertUITouchEventToNS:(UITouch *) touchEvent;
+(float) fatFingerOffset;

@end
