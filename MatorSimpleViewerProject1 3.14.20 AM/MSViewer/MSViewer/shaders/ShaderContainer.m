//
//  DMShaderContainer.m
//  DriskelMator
//
//  Created by Brolis on 5/18/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "MSVShaderContainer.h"
#import "MSVShaderProgram.h"
#import "MSVShaderConstants.h"

MSVShaderContainer *_sharedContainer = NULL;


@interface MSVShaderContainer()
{
    NSMutableDictionary *_shaderDictionary;
}
@end

@implementation MSVShaderContainer

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
    MSVShaderProgram *primitiveShader    = [MSVShaderProgram createWithVertexShaderFileName:@"PrimitivesVertShader" andFgramentShaderFileName:@"PrimitivesFragShader"];
    
    [self addShaderProgram:primitiveShader withName:[MSVShaderConstants primitiveShaderName]];
}

-(MSVShaderProgram*) getShaderProgramFromName:(NSString*) name
{
    return [_shaderDictionary objectForKey:name];
}

+(instancetype) sharedInstance
{
    if(!_sharedContainer)
    {
        _sharedContainer = [[MSVShaderContainer alloc] init];
    }
    
    return _sharedContainer;
}

-(void) addShaderProgram:(MSVShaderProgram*) shaderProgram withName:(NSString*) name
{
    [_shaderDictionary setObject:shaderProgram forKey:name];
}

@end