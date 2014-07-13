//
//  DMShaderProgram.h
//  DriskelMator
//
//  Created by Brolis on 5/17/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMatrix4.h>


@interface MSVShaderProgram : NSObject

@property (nonatomic, readonly) GLuint programHandle;

+(instancetype) createWithVertexShaderFileName:(NSString*) vertexShaderFileName andFgramentShaderFileName:(NSString*) fragmentShaderFileName;

-(GLuint) getUniformLocationFromName:(NSString*) name;
-(GLuint) getAttributeLocationFromName:(NSString*) name;

-(void) enableVertexAttribPointerToLocationName:(NSString*) locationName size:(int)size andVertices:(const float*) vertices;
-(void) enableVertexAttribPointerToLocation:(GLuint) location size:(int)size andVertices:(const float*) vertices;


-(void) setToLocationName:(NSString*)locationName GLKMatrix4:(GLKMatrix4) matrix4;
-(void) setToLocation:(GLuint) location GLKMatrix4:(GLKMatrix4) matrix4;

-(void) setToLocationName:(NSString*)locationName x:(float) x;
-(void) setToLocation:(GLuint)location x:(float) x;

-(void) setToLocationName:(NSString*)locationName x:(float) x y:(float) y z:(float) z;
-(void) setToLocation:(GLuint)location x:(float) x y:(float) y z:(float) z;

-(void) use;
-(void) dump;

@end
