//
//  MSVScreen.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKVector2.h>

@interface MSVScreen : NSObject

+(void) initWithScreenBounds:(CGRect) bounds;
+(CGRect) screenBounds;

+(void) tearDown;

+(void) setScale:(float) scale;
+(float) scale;

+(float) left;
+(float) right;
+(float) top;
+(float) bot;
+(float) height;
+(float) width;
+(float) halfHeight;
+(float) halfWidth;
+(float) aspect;
+(float) fatFingerOffset;

+(float) leftNS;
+(float) rightNS;
+(float) topNS;
+(float) botNS;

+(CGPoint) pointInNS:(CGPoint)p;
+(CGSize)  sizeInNS:(CGSize)size;

+(CGPoint) convertToNS:(float) x : (float) y;
+(CGPoint) convertUITouchEventToNS:(UITouch *) touchEvent;

+(CGPoint) scaledPoint:(CGPoint) point;
+(CGSize) scaledSize:(CGSize) size;

+(CGPoint) centerPoint;
+(CGPoint) ciImageSpacePoint:(const CGPoint) point;

+(CGRect) makeRect:(CGPoint) posA :(CGPoint) posB;

@end
