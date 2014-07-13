//
//  MSVShaderConstants.m
//  DriskelMator
//
//  Created by Brolis on 5/17/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVShaderConstants.h"

@implementation MSVShaderConstants

+(NSString*) projectionMatrixName
{
    return @"projectionMatrix";
}

+(NSString*) modelMatrixName
{
    return @"modelMatrix";
}

+(NSString*) viewMatrixName
{
    return @"viewMatrix";
}

+(NSString*) positionName
{
    return @"vPosition";
}

+(NSString*) colorName
{
    return @"vColor";
}

+(NSString*) backgroundTypeName
{
    return @"fBackgroundType";
}

+(NSString*) primitiveShaderName
{
    return @"primitiveShader";
}

+(NSString*) backgroundShaderName
{
    return @"backgroundShader";
}

@end
