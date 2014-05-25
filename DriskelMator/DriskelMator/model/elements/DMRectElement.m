//
//  DMRectElement.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <GLKit/GLKMatrix4.h>
#import <GLKit/GLKVector3.h>

#import "DMRectElement.h"
#import "DMGraphics.h"

@implementation DMRectElement

@synthesize bounds = _bounds;

-(id) initWithBBox:(CGRect) bbox translation:(GLKMatrix4) translation andRotation:(GLKMatrix4)rotation
{
    self = [super initWithBBox:bbox translation:translation andRotation:rotation];
    
    if(self)
    {
        _bounds = bbox;
    }
    return self;
}

+(instancetype) createWithBounds:(CGRect) bounds translation:(GLKMatrix4) translation andRotation:(GLKMatrix4)rotation
{
    return [[DMRectElement alloc] initWithBBox:bounds translation:translation andRotation:rotation];
}

-(void) dump
{
    //print something
}

-(void) draw
{
    float red = self.selected ? 1 : 0;
    
    [DMGraphics drawRect:self.bounds trasform:self.transform andColor: GLKVector3Make(red, 1.f, 1.f)];
}

@end
