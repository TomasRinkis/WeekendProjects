//
//  DMAbtractElement.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMAbtractElement.h"
#import "DMScreen.h"
#import "DMGeometryUtils.h"


#import <GLKit/GLKVector4.h>
#import <GLKit/GLKMatrix4.h>

@implementation DMAbtractElement


@synthesize dirtyBBox   = _dirtyBBox;
@synthesize transform   = _transform;
@synthesize rotation    = _rotation;
@synthesize translation = _translation;

@synthesize position    = _position;
@synthesize rotAngle    = _rotAngle;

@synthesize selected    = _selected;
@synthesize debugBBox   = _debugBBox;

-(id) initWithBBox:(CGRect) bbox translation:(GLKMatrix4) translation andRotation:(GLKMatrix4)rotation
{
    self  = [super init];
    
    if(self)
    {
        _dirtyBBox  = bbox;
        _transform  = GLKMatrix4Identity;
        _rotation   = rotation;
        _translation= translation;
        _position   = GLKVector2Make(0.f, 0.f);
        _rotAngle   = 0;
        
        _selected   = NO;
        _debugBBox  = CGRectZero;
    }
    
    return self;
}

-(GLKMatrix4) transform
{
    return GLKMatrix4Multiply(self.translation, self.rotation);
}

-(GLKVector2) position
{
    return [DMGeometryUtils posFromFromGLKMatrix4:self.translation];
}

-(float) rotAngle
{
    return [DMGeometryUtils rotAngleFromGLKMatrix4:self.rotation];
}

-(void) dump
{
}

-(void) draw
{
}

-(BOOL) intersectsWithPoint:(GLKVector2)point
{
    const float bboxWD     = _dirtyBBox.size.width;
    const float bboxHT     = _dirtyBBox.size.height;
    
    const float bboxHalfWD     = bboxWD/2.f;
    const float bboxHalfHT     = bboxHT/2.f;
    
    const float fatFingerOffset = [DMScreen fatFingerOffset];
    const float fatFingerHalfOffset = fatFingerOffset/2.f;
    
    GLKVector4 bboxCenter = GLKMatrix4MultiplyVector4(self.translation, GLKVector4Make(_dirtyBBox.origin.x - bboxHalfWD, _dirtyBBox.origin.y - bboxHalfHT, 0.f, 1.f));
    
    CGRect boundA =  CGRectMake(bboxCenter.x, bboxCenter.y, bboxWD, bboxHT);
    CGRect boundB =  CGRectMake(point.x - fatFingerHalfOffset, point.y - fatFingerHalfOffset, fatFingerOffset, fatFingerOffset);
    
    return CGRectIntersectsRect(boundB, boundA);
}

@end
