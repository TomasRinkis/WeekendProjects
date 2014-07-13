//
//  DMShaderContainer.h
//  DriskelMator
//
//  Created by Brolis on 5/18/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSVShaderProgram;

@interface MSVShaderContainer : NSObject

+(instancetype) sharedInstance;

-(MSVShaderProgram*) getShaderProgramFromName:(NSString*) name;
-(void) addShaderProgram:(MSVShaderProgram*) shaderProgram withName:(NSString*) name;

@end
