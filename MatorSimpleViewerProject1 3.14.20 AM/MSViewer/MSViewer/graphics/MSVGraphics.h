//
//  DMGraphics.h
//  DriskelMator
//
//  Created by Brolis on 5/17/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMathTypes.h>

@class MSVShaderProgram;

@interface MSVGraphics : NSObject

+(void) setShaderProgram:(MSVShaderProgram*) shaderProgram;

#pragma mark initilization
+(void) init;
+(void) tearDown;


#pragma mark matrix loading (move to shader)
+(void) loadProjectionMatrix:(GLKMatrix4) projectionMatrix;
+(void) loadModelMatrix:(GLKMatrix4) modelMatrix;
+(void) loadViewMatrix:(GLKMatrix4)  viewMatrix;
+(void) loadDefaultMatrixes;

#pragma mark drawing
+(void) drawLineFrom:(CGPoint) from :(CGPoint) to andColor:(GLKVector3) color;
+(void) drawLineQuadAt:(CGPoint) center withSize:(CGSize) size andColor:(GLKVector3) color;
+(void) drawLineCircleAt:(CGPoint) center withRadius:(float) radius andColor:(GLKVector3) color;

+(void) drawCircleAt:(GLKVector2) pos withRadius:(float) radius andTrasform:(GLKMatrix4) transform andColor:(GLKVector3) color;
+(void) drawRect:(CGRect) rect trasform:(GLKMatrix4) transform andColor:(GLKVector3) color;
+(void) drawRect:(CGRect) rect andColor:(GLKVector3) color;

+(void) drawSolidQuadAt:(CGPoint) center withSize:(CGSize) size andColor:(GLKVector3) color;
+(void) drawbackgroundWithColor:(GLKVector4)color;

@end


extern void setShadowHighlightAmount(const float amount);
extern void setShadowAmount(const float amount);

extern float getShadowHighlightAmount(void);
extern float getShadowAmount(void);
