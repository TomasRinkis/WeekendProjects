//
//  MSVAbstractTool.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVAbstractToolButton.h"

@implementation MSVAbstractToolButton

-(instancetype) initWithBounds:(CGRect)bounds
{
    self = [super init];
    
    if(self)
    {
        self.frame = bounds;
    }
    
    return self;
}

-(NSString*) iconName
{
    [NSException raise:@"Invalid implementation" format:@"%@ implement in supper class!", NSStringFromClass([self class])];
    
    return nil;
}

- (UIImage*) icon
{
    return [UIImage imageNamed:self.iconName];
}

-(void) useButtonReleasedBackground
{
    self.backgroundColor    = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.f];
    
}

-(void) useButtonPressedBackground
{
    self.backgroundColor    = [UIColor colorWithRed:1.f green:0.f blue:0.f alpha:1.f];
}

-(void) pressButton
{
    [NSException raise:@"Invalid implementation" format:@"%@ implement in supper class!", NSStringFromClass([self class])];
}

-(void) releaseButton
{
    [NSException raise:@"Invalid implementation" format:@"%@ implement in supper class!", NSStringFromClass([self class])];
}

+(int) dimension
{
    return 100;
}

+(int) halfDimension
{
    return [MSVAbstractToolButton dimension]/2;
}

@end
