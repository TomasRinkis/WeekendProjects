//
//  DMShaderContainer.m
//  DriskelMator
//
//  Created by Brolis on 5/18/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMShaderContainer.h"
#import "DMShaderProgram.h"
#import "DMShaderConstants.h"

DMShaderContainer *_sharedContainer = NULL;


@interface DMShaderContainer()
{
    NSMutableDictionary *_shaderDictionary;
}
@end

@implementation DMShaderContainer

-(id) init
{
    self = [super init];
    
    if(self)
    {
        _sharedContainer    = NULL;
        _shaderDictionary   = [[NSMutableDictionary alloc] init];
    
        [self loadDefaultShaders];
    }

    return self;
}

-(void) create
{
}

-(void) destroy
{
    _sharedContainer = NULL;
}

-(void) loadDefaultShaders
{
    DMShaderProgram *primitiveShader    = [DMShaderProgram createWithVertexShaderFileName:@"PrimitivesVertShader" andFgramentShaderFileName:@"PrimitivesFragShader"];
    DMShaderProgram *backgroundShader   = [DMShaderProgram createWithVertexShaderFileName:@"BackgroundVertShader" andFgramentShaderFileName:@"BackgroundFragShader"];
    
    [self addShaderProgram:primitiveShader withName:[DMShaderConstants primitiveShaderName]];
    [self addShaderProgram:backgroundShader withName:[DMShaderConstants backgroundShaderName]];
}

-(DMShaderProgram*) getShaderProgramFromName:(NSString*) name
{
    return [_shaderDictionary objectForKey:name];
}

+(instancetype) sharedInstance
{
    if(!_sharedContainer)
    {
        _sharedContainer = [[DMShaderContainer alloc] init];
    }
    
    return _sharedContainer;
}

-(void) addShaderProgram:(DMShaderProgram*) shaderProgram withName:(NSString*) name
{
    [_shaderDictionary setObject:shaderProgram forKey:name];
}

@end