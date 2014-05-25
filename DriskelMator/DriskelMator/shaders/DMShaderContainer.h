//
//  DMShaderContainer.h
//  DriskelMator
//
//  Created by Brolis on 5/18/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMSingletonProtocol.h"

@class DMShaderProgram;

@interface DMShaderContainer : NSObject<DMSingletonProtocol>

-(DMShaderProgram*) getShaderProgramFromName:(NSString*) name;
-(void) addShaderProgram:(DMShaderProgram*) shaderProgram withName:(NSString*) name;

@end
