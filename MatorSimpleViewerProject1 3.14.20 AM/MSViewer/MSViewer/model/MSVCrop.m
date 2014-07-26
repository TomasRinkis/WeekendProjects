//
//  MSVCrop.m
//  MSViewer
//
//  Created by Brolis on 7/26/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCrop.h"

@implementation MSVCrop

-(instancetype) initWithHeight:(int) height andWidth:(int) width
{
    self = [super init];
    
    if(self)
    {
        self.width = width;
        self.height = height;
    }
    
    return self;
}

-(CGSize) size
{
    return CGSizeMake(self.width, self.height);
}

+(instancetype) createWithHeight:(int) height andWidth:(int) width
{
    return [[MSVCrop alloc] initWithHeight:height andWidth:width];
}

@end
