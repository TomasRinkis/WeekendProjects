//
//  DMCircleElement.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMCircleElement.h"
#import <GLKit/GLKMatrix4.h>
#import <GLKit/GLKVector2.h>
#import <GLKit/GLKVector3.h>

#import "DMGraphics.h"

@implementation DMCircleElement

@synthesize bounds = _bounds;

-(id) initWithBounds :(CGRect) bounds translation:(GLKMatrix4) translation andRotation:(GLKMatrix4)rotation
{
    self = [super initWithBBox:bounds translation:translation andRotation:rotation];
    
    if(self)
    {
        _bounds = bounds;
        
    }
    
    return self;
}

+(instancetype) createWithBounds:(CGRect) bounds translation:(GLKMatrix4) translation andRotation:(GLKMatrix4)rotation
{
    return [[DMCircleElement alloc] initWithBounds:bounds translation:translation andRotation:rotation];
}

-(void) dump
{
    //print something
}

-(void) draw
{
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float radius = self.bounds.size.height;
    
    float red = self.selected ? 1 : 0;

    [DMGraphics drawCircleAt:GLKVector2Make(x, y) withRadius:radius andTrasform:self.transform andColor:GLKVector3Make(red, 1.f, 0.f)];
}


@end
