//
//  MSVCanvasAbstractElement.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasAbstractElement.h"
#import "MSVScreen.h"

@implementation MSVCanvasAbstractElement

@synthesize pos     = _pos;
@synthesize size    = _size;
@synthesize selected= _selected;

-(instancetype) init
{
    self = [super init];
    
    if(self)
    {
        self.pos    = CGPointZero;
        self.size   = CGSizeZero;
        self.selected = FALSE;
    }
    
    return self;
}

-(instancetype) initWithPos:(CGPoint) pos andSize:(CGSize) size
{
    self = [super init];
    
    if(self)
    {
        self.pos    = pos;
        self.size   = size;
    }
    
    return self;
}

-(void) drawWithCIContext:(CIContext *)contextCI
{
    [NSException raise:@"Invalid implementation" format:@"%@ implement in supper class!", NSStringFromClass([self class])];
}

-(BOOL) intersectsInPos:(CGPoint) pos
{
    const CGSize fatFingerSize = CGSizeMake([MSVScreen fatFingerOffset], [MSVScreen fatFingerOffset]);
    
    CGRect rectA = CGRectMake(pos.x, pos.y, fatFingerSize.width, fatFingerSize.height);
    CGRect rectB = CGRectMake(self.pos.x, self.pos.y, self.size.width, self.size.height);
    
    return CGRectIntersectsRect(rectA, rectB);
}

@end
