//
//  DMGeometryUtils.h
//  DriskelMator
//
//  Created by Brolis on 5/18/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKVector2.h>


@interface DMGeometryUtils : NSObject

//<move to utils
+(CGRect) makeRect:(GLKVector2) posA :(GLKVector2) posB;
+(float) radToDeg:(float) rad;
+(float) rotAngleFromGLKMatrix4:(GLKMatrix4) matrix4;
+(GLKVector2) posFromFromGLKMatrix4:(GLKMatrix4) matrix4;

@end
