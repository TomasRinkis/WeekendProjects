//
//  MSVDeleteTool.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVDeleteToolButton.h"
#import "MSVToolInventory.h"
#import "MSVNotifications.h"

@implementation MSVDeleteToolButton

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
    return @"delete.png";
}

+(instancetype) createWithFrame:(CGRect) frame
{
    return [[MSVDeleteToolButton alloc] initWithBounds:frame];
}

-(void) pressButton
{
    [[MSVToolInventory sharedInstance] unselectAllTools];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:[MSVNotification CanvasDeleteState] object:self];
    
    [self setSelected:YES];
    [super useButtonPressedBackground];
}

-(void) releaseButton
{
    [self setSelected:NO];
    [super useButtonReleasedBackground];
}
@end
