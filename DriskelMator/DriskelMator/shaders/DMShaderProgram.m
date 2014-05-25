//
//  DMShaderProgram.m
//  DriskelMator
//
//  Created by Brolis on 5/17/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMShaderProgram.h"
#import "DMShaderUtils.h"
#import "DMPath.h"

@interface DMShaderProgram()
{
    NSString *_vertShaderPathName;
    NSString *_fragShaderPathName;
    
    NSString *_fragShaderSource;
    NSString *_vertShaderSource;
}
@end

@implementation DMShaderProgram

@synthesize programHandle = _programHandle;

-(id) initWithVertexShaderFileName:(NSString*) vertexShaderFileName andFgramentShaderFileName:(NSString*) fragmentShaderFileName
{
    self = [super init];
    
    if(self)
    {
        //<init source
        _vertShaderPathName = [DMPath pathInBundleForResource:vertexShaderFileName ofType:@"glsl"];
        _fragShaderPathName = [DMPath pathInBundleForResource:fragmentShaderFileName ofType:@"glsl"];
        
        _vertShaderSource  = [NSString stringWithContentsOfFile:_vertShaderPathName encoding:NSUTF8StringEncoding error:nil];
        _fragShaderSource  = [NSString stringWithContentsOfFile:_fragShaderPathName encoding:NSUTF8StringEncoding error:nil];
        
        GLuint vertexShaderHandle     = [DMShaderUtils compileShaderOfType:GL_VERTEX_SHADER file:_vertShaderPathName];
        GLuint fragmentShaderHandle   = [DMShaderUtils compileShaderOfType:GL_FRAGMENT_SHADER file:_fragShaderPathName];
        
        //<compile
        _programHandle = [DMShaderUtils compileProgramWithVertexShaderHandle:vertexShaderHandle andFragmentShaderHandle:fragmentShaderHandle];
        
        //<link
        [DMShaderUtils linkProgram:_programHandle];
        
        //<detach
        [DMShaderUtils detachShader:vertexShaderHandle fromProgram:_programHandle];
        [DMShaderUtils detachShader:fragmentShaderHandle fromProgram:_programHandle];
    }
    
    return self;
}

+(instancetype) createWithVertexShaderFileName:(NSString*) vertexShaderFileName andFgramentShaderFileName:(NSString*) fragmentShaderFileName
{
    return [[DMShaderProgram alloc] initWithVertexShaderFileName:vertexShaderFileName andFgramentShaderFileName:fragmentShaderFileName];
}

-(void) dealloc
{
    glDeleteProgram(_programHandle);
}

-(GLuint) getUniformLocationFromName:(NSString*) name
{
    return glGetUniformLocation(_programHandle, [name UTF8String]);
}

-(GLuint) getAttributeLocationFromName:(NSString*) name
{
    return glGetAttribLocation(_programHandle, [name UTF8String]);
}

-(void) enableVertexAttribPointerToLocationName:(NSString*) locationName size:(int)size andVertices:(const float*) vertices
{
    GLuint location = [self getAttributeLocationFromName:locationName];
    [self enableVertexAttribPointerToLocation:location size:size andVertices:vertices];
}

-(void) enableVertexAttribPointerToLocation:(GLuint) location size:(int)size andVertices:(const float*) vertices
{
    glVertexAttribPointer(location, size, GL_FLOAT, GL_FALSE, 0, vertices);
    glEnableVertexAttribArray(location);
}

-(void) setToLocationName:(NSString*)locationName x:(float) x
{
    GLuint location = [self getAttributeLocationFromName:locationName];
    [self setToLocation:location x:x];
}

-(void) setToLocation:(GLuint)location x:(float) x
{
    glVertexAttrib1f(location, x);
}

-(void) setToLocationName:(NSString*)locationName GLKMatrix4:(GLKMatrix4) matrix4
{
    GLuint location = [self getUniformLocationFromName:locationName];
    [self setToLocation:location GLKMatrix4:matrix4];
}

-(void) setToLocationName:(NSString*)locationName x:(float) x y:(float) y z:(float) z
{
    GLuint location = [self getAttributeLocationFromName:locationName];
    [self setToLocation:location x:x y:y z:z];
}

-(void) setToLocation:(GLuint) location GLKMatrix4:(GLKMatrix4) matrix4
{
    glUniformMatrix4fv(location, 1, GL_FALSE, matrix4.m);
}

-(void) setToLocation:(GLuint)location x:(float) x y:(float) y z:(float) z
{
    glVertexAttrib3f(location, x, y, z);
}

-(void) use
{
    glUseProgram(_programHandle);
}

-(void) dump
{
    NSLog(@"vertex shader: %@ soure: %@", _vertShaderPathName, _vertShaderSource);
    NSLog(@"vertex shader: %@ soure: %@", _fragShaderPathName, _fragShaderSource);
}

@end