//
//  MSVZoomToolButton.m
//  MSViewer
//
//  Created by Brolis on 7/23/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVZoomToolButton.h"
#import "MSVToolInventory.h"
#import "MSVNotifications.h"

@implementation MSVZoomToolButton

-(instancetype) initWithBounds:(CGRect)bounds
{
    self = [super initWithBounds:bounds];
    
    if(self)
    {
        [self setImage:self.icon forState:UIControlStateNormal];
        [self addTarget:self action:@selector(pressButton) forControlEvents:UIControlEventTouchDown];
    }
    
    return self;
}

-(void) dealloc
{
}

-(NSString*) iconName
{
    return @"zoom.png";
}

+(instancetype) createWithFrame:(CGRect) frame
{
    return [[MSVZoomToolButton alloc] initWithBounds:frame];
}

-(void) pressButton
{
    [[MSVToolInventory sharedInstance] unselectAllTools];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[MSVNotification CanvasZoomState] object:self];
    
    [self setSelected:YES];
    [super useButtonPressedBackground];
}

-(void) releaseButton
{
    [self setSelected:NO];
    [super useButtonReleasedBackground];
}
@end