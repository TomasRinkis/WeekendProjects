//
//  DMGraphics.m
//  DriskelMator
//
//  Created by Brolis on 5/17/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMGraphics.h"
#import "DMShaderProgram.h"
#import "DMShaderConstants.h"

#import "DMPath.h"
#import "DMScreen.h"

#import <GLKit/GLKMatrix4.h>

//<http://glsl.heroku.com/e#16060.0

//<state
GLKMatrix4 _projectionMatrix;
GLKMatrix4 _modelMatrix;
GLKMatrix4 _viewMatrix;

DMShaderProgram *_shaderProgram;


@implementation DMGraphics

+(void) init
{
    _shaderProgram      = NULL;
    _projectionMatrix   = GLKMatrix4Identity;
    _modelMatrix        = GLKMatrix4Identity;
    _viewMatrix         = GLKMatrix4Identity;
}

+(void) setShaderProgram:(DMShaderProgram*) shaderProgram
{
    _shaderProgram = shaderProgram;
    
    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");

    [_shaderProgram setToLocationName:[DMShaderConstants projectionMatrixName] GLKMatrix4:_projectionMatrix];
    [_shaderProgram setToLocationName:[DMShaderConstants modelMatrixName] GLKMatrix4:_modelMatrix];
    [_shaderProgram setToLocationName:[DMShaderConstants viewMatrixName] GLKMatrix4:_viewMatrix];
}

+(void) loadDefaultMatrixes
{
    GLKMatrix4 projectionMatrix =  GLKMatrix4MakeOrtho([DMScreen leftNS], [DMScreen rightNS], [DMScreen botNS], [DMScreen topNS], -1.f, 1.f);
    GLKMatrix4 modelMatrix      =  GLKMatrix4Identity;
    GLKMatrix4 viewMatrix       =  GLKMatrix4Identity;
    
    [DMGraphics loadProjectionMatrix:projectionMatrix];
    [DMGraphics loadModelMatrix:modelMatrix];
    [DMGraphics loadViewMatrix:viewMatrix];
}

+(void) loadProjectionMatrix:(GLKMatrix4) projectionMatrix
{
    _projectionMatrix = projectionMatrix;
}

+(void) loadModelMatrix:(GLKMatrix4) modelMatrix
{
    _modelMatrix = modelMatrix;
}

+(void) loadViewMatrix:(GLKMatrix4)  viewMatrix
{
    _viewMatrix = viewMatrix;
}

+(void) tearDown
{
    _projectionMatrix   = GLKMatrix4Identity;
    _modelMatrix        = GLKMatrix4Identity;
    _viewMatrix         = GLKMatrix4Identity;
}

+(void) drawLineFrom:(CGPoint) from :(CGPoint) to andColor:(GLKVector3) color
{
    GLfloat vertices[] =
    {
        from.x, from.y, 0.f,
        to.x,   to.y,   0.f
    };
    
    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");
    
    [_shaderProgram use];
    [_shaderProgram setToLocationName:[DMShaderConstants colorName] x:color.r y:color.g z:color.b];
    [_shaderProgram enableVertexAttribPointerToLocationName:[DMShaderConstants positionName] size:3 andVertices:vertices];
    
    glDrawArrays(GL_LINES, 0, 2);
}

+(void) drawLineQuadAt:(CGPoint) center withSize:(CGSize) size andColor:(GLKVector3) color
{
    const float x = center.x;
    const float y = center.y;
    
    const float hh = size.height/2.f;
    const float hw = size.width/2.f;
    
    GLfloat vertices[] =
    {
        x - hw, y - hh, 0,
        x - hw, y + hh, 0,
        x + hw, y + hh, 0,
        x + hw, y - hh, 0
    };

    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");

    [_shaderProgram use];
    [_shaderProgram setToLocationName:[DMShaderConstants colorName] x:color.r y:color.g z:color.b];
    [_shaderProgram enableVertexAttribPointerToLocationName:[DMShaderConstants positionName] size:3 andVertices:vertices];

    glDrawArrays(GL_LINE_LOOP, 0, 4);
}


+(void) drawRect:(CGRect) rect andColor:(GLKVector3) color
{
    const float x = rect.origin.x;
    const float y = rect.origin.y;
    
    const float hh = rect.size.height/2.f;
    const float hw = rect.size.width/2.f;
    
    GLfloat vertices[] =
    {
        x - hw, y - hh, 0,
        x - hw, y + hh, 0,
        x + hw, y + hh, 0,
        x + hw, y - hh, 0
    };
    
    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");
    
    [_shaderProgram use];
    [_shaderProgram setToLocationName:[DMShaderConstants colorName] x:color.r y:color.g z:color.b];
    [_shaderProgram enableVertexAttribPointerToLocationName:[DMShaderConstants positionName] size:3 andVertices:vertices];
    
    glDrawArrays(GL_LINE_LOOP, 0, 4);
}


+(void) drawRect:(CGRect) rect trasform:(GLKMatrix4) transform andColor:(GLKVector3) color
{
    const float x = rect.origin.x;
    const float y = rect.origin.y;
    
    const float hh = rect.size.height/2.f;
    const float hw = rect.size.width/2.f;
    
    GLKVector4 a = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(x - hw, y - hh, 0, 1));
    GLKVector4 b = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(x - hw, y + hh, 0, 1));
    GLKVector4 c = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(x + hw, y + hh, 0, 1));
    GLKVector4 d = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(x + hw, y - hh, 0, 1));
    
    
    GLfloat vertices[] =
    {
        a.x, a.y, 0,
        b.x, b.y, 0,
        c.x, c.y, 0,
        d.x, d.y, 0
    };
    
    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");

    [_shaderProgram use];
    [_shaderProgram setToLocationName:[DMShaderConstants colorName] x:color.r y:color.g z:color.b];
    [_shaderProgram enableVertexAttribPointerToLocationName:[DMShaderConstants positionName] size:3 andVertices:vertices];

    glDrawArrays(GL_LINE_LOOP, 0, 4);
}


+(void) drawCircleAt:(GLKVector2) pos withRadius:(float) radius andTrasform:(GLKMatrix4) transform andColor:(GLKVector3) color
{
    const float x = pos.x;
    const float y = pos.y;
    
    GLKVector4 center = GLKMatrix4MultiplyVector4(transform, GLKVector4Make(x, y, 0, 1));
    
    
    const int segments = 40;
    
    GLfloat vertices[segments*2];
    
    int count=0;
    
    for (GLfloat i = 0; i < 360.0f; i+=(360.0f/segments))
    {
        vertices[count++] = (cos([DMGraphics degreeToRad:(i)])*radius) + center.x;
        vertices[count++] = (sin([DMGraphics degreeToRad:(i)])*radius) + center.y;
    }
    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");

    [_shaderProgram use];
    [_shaderProgram setToLocationName:[DMShaderConstants colorName] x:color.r y:color.g z:color.b];
    [_shaderProgram enableVertexAttribPointerToLocationName:[DMShaderConstants positionName] size:2 andVertices:vertices];

    glDrawArrays(GL_LINE_LOOP, 0, segments);
}


+(void) drawbackgroundWithColor:(GLKVector4)color
{
    const float x = 0.f;
    const float y = 0.f;
    
    const float hh = [DMScreen topNS];
    const float hw = [DMScreen leftNS];
    
    GLfloat vertices[] =
    {
        x - hw, y - hh, 0,
        x - hw, y + hh, 0,
        x + hw, y + hh, 0,
        x + hw, y - hh, 0
    };
    
    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");
    
    [_shaderProgram use];
    [_shaderProgram setToLocationName:[DMShaderConstants colorName] x:color.r y:color.g z:color.b];
    [_shaderProgram setToLocationName:[DMShaderConstants backgroundTypeName] x:color.a];
    
    [_shaderProgram enableVertexAttribPointerToLocationName:[DMShaderConstants positionName] size:3 andVertices:vertices];
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}

+(void) drawSolidQuadAt:(CGPoint) center withSize:(CGSize) size andColor:(GLKVector3) color;
{
    const float x = center.x;
    const float y = center.y;
    
    const float hh = size.height/2.f;
    const float hw = size.width/2.f;
    
    GLfloat vertices[] =
    {
        x - hw, y - hh, 0,
        x - hw, y + hh, 0,
        x + hw, y + hh, 0,
        x + hw, y - hh, 0
    };
    
    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");

    [_shaderProgram use];
    [_shaderProgram setToLocationName:[DMShaderConstants colorName] x:color.r y:color.g z:color.b];
    [_shaderProgram enableVertexAttribPointerToLocationName:[DMShaderConstants positionName] size:3 andVertices:vertices];

    glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
}


+(float) degreeToRad:(float) deg
{
    return deg * M_PI/180.f;
}


+(void) drawLineCircleAt:(CGPoint) center withRadius:(float) radius andColor:(GLKVector3) color
{
    const int segments = 40;
    
    GLfloat vertices[segments*2];
    
    int count=0;
    
    for (GLfloat i = 0; i < 360.0f; i+=(360.0f/segments))
    {
        vertices[count++] = (cos([DMGraphics degreeToRad:(i)])*radius) + center.x;
        vertices[count++] = (sin([DMGraphics degreeToRad:(i)])*radius) + center.y;
    }

    NSAssert(_shaderProgram, @"_shaderProgram is NULL!, first set shader: +(void) setShaderProgram:");

    [_shaderProgram use];
    [_shaderProgram setToLocationName:[DMShaderConstants colorName] x:color.r y:color.g z:color.b];
    [_shaderProgram enableVertexAttribPointerToLocationName:[DMShaderConstants positionName] size:2 andVertices:vertices];

    glDrawArrays(GL_LINE_LOOP, 0, segments);
}
@end
