//
//  DMToolPalleteController.m
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMToolPalleteController.h"
#import "DMToolsPalleteVIew.h"

@implementation DMToolPalleteController


@synthesize toolPalleteView = _toolPalleteView;

- (id)initWithView:(DMToolsPalleteVIew*) view;
{
    self = [super init];
    if (self)
    {
        _toolPalleteView = view;
        self.view = _toolPalleteView;
        _toolPalleteView.controllerDelegate = self;
    }
    return self;
}

+(instancetype) createWithView:(DMToolsPalleteVIew*) view
{
    return [[DMToolPalleteController alloc] initWithView:view];
}

- (void)touchesBegan:(NSSet *)touches inPos:(GLKVector2) pos
{
    
}

- (void)touchesMoved:(NSSet *)touches inPos:(GLKVector2) pos
{
    
}


- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos
{
    
}


- (void)touchesCancelled:(NSSet *)touches inPos:(GLKVector2) pos
{
    
}

- (void)update
{
}

- (void)draw
{
    
}


@end
