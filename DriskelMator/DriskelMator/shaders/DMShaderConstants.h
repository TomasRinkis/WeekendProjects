//
//  DMShaderConstants.h
//  DriskelMator
//
//  Created by Brolis on 5/17/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMShaderConstants : NSObject

+(NSString*) projectionMatrixName;
+(NSString*) modelMatrixName;
+(NSString*) viewMatrixName;

+(NSString*) positionName;
+(NSString*) colorName;
+(NSString*) backgroundTypeName;


+(NSString*) primitiveShaderName;
+(NSString*) backgroundShaderName;

@end
