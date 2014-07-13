//
//  DMShaderUtils.h
//  DriskelMator
//
//  Created by Brolis on 5/17/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSVShaderUtils : NSObject

+(GLuint)compileShaderOfType:(GLenum)type file:(NSString *)file;
+(GLuint)compileProgramWithVertexShaderHandle:(GLuint) vertexShaderHandle andFragmentShaderHandle:(GLuint)fragmentShaderHandle;

+(BOOL)linkProgram:(GLuint)program;
+(void)detachShader:(GLuint) shaderHandle fromProgram:(GLuint) programHandle;

@end
