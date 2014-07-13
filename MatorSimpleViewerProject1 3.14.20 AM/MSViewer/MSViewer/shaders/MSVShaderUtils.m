//
//  DMShaderUtils.m
//  DriskelMator
//
//  Created by Brolis on 5/17/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "MSVShaderUtils.h"

@implementation MSVShaderUtils

+(GLuint)compileShaderOfType:(GLenum)type file:(NSString *)file
{
    GLuint shaderHandle;
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return -1;
    }
    
    shaderHandle = glCreateShader(type);
    glShaderSource(shaderHandle, 1, &source, NULL);
    glCompileShader(shaderHandle);
    
    
    GLint logLength;
    glGetShaderiv(shaderHandle, GL_INFO_LOG_LENGTH, &logLength);
    
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(shaderHandle, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
    
    glGetShaderiv(shaderHandle, GL_COMPILE_STATUS, &status);
    
    if (status == 0)
    {
        glDeleteShader(shaderHandle);
        return -1;
    }
    
    return shaderHandle;
}

+(GLuint)compileProgramWithVertexShaderHandle:(GLuint) vertexShaderHandle andFragmentShaderHandle:(GLuint)fragmentShaderHandle
{
    GLuint programHandle;
    
    programHandle = glCreateProgram();
    
    glAttachShader(programHandle, vertexShaderHandle);
    glAttachShader(programHandle, fragmentShaderHandle);
    
    return programHandle;
}


+(BOOL)linkProgram:(GLuint)program
{
    GLint status;
    glLinkProgram(program);
    
    GLint logLength;
    glGetProgramiv(program, GL_INFO_LOG_LENGTH, &logLength);
    
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(program, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(program, GL_LINK_STATUS, &status);
    
    if (status == 0)
    {
        return NO;
    }
    
    return YES;
}

+(void)detachShader:(GLuint) shaderHandle fromProgram:(GLuint) programHandle
{
    glDetachShader(programHandle, shaderHandle);
    glDeleteShader(shaderHandle);
}

@end
