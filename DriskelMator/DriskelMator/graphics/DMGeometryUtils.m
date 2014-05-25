//
//  DMGeometryUtils.m
//  DriskelMator
//
//  Created by Brolis on 5/18/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMGeometryUtils.h"

@implementation DMGeometryUtils

+(CGRect) makeRect:(GLKVector2) posA :(GLKVector2) posB
{
    GLKVector2 centerPos = GLKVector2Subtract(posB, posA);
    centerPos = GLKVector2DivideScalar(centerPos, 2.f);
    centerPos = GLKVector2Add(posA, centerPos);
    
    float width = ABS(posA.x - posB.x);
    float height = ABS(posA.y - posB.y);
    
    return CGRectMake(centerPos.x, centerPos.y, width, height);
}

+(float) radToDeg:(float) rad
{
    return rad * 180/M_PI;
}

+(float) rotAngleFromGLKMatrix4:(GLKMatrix4) matrix4
{
    return asinf(-matrix4.m10);
}

+(GLKVector2) posFromFromGLKMatrix4:(GLKMatrix4) matrix4
{
    const float x = matrix4.m30;
    const float y = matrix4.m31;

    return GLKVector2Make(x, y);
}

@end
