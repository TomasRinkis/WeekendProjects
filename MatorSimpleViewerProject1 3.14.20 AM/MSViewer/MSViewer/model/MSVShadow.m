//
//  MSVShadow.m
//  MSViewer
//
//  Created by Brolis on 7/24/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVShadow.h"

@implementation MSVShadow

@synthesize red;
@synthesize green;
@synthesize blue;

@synthesize angle;
@synthesize offset;
@synthesize blur;

@synthesize on;


-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
        self.red = 0.f;
        self.green = 0.f;
        self.blue = 0.f;
        
        self.angle = 0.f;
        self.offset = 0.f;
        self.blue = 0.f;
        
        self.on = false;
    }
    
    return self;
}


+(instancetype) create
{
    return [[MSVShadow alloc] init];
}

@end