//
//  MSVNotifications.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVNotifications.h"

@implementation MSVNotification

+(NSString*) CanvasSelectState;
{
    return @"MSVNotificationSetCanvasSelectState";
}

+(NSString*) CanvasCropState;
{
    return @"MSVNotificationSetCanvasCropState";
}

+(NSString*) CanvasDeleteState;
{
    return @"MSVNotificationSetCanvasDeleteState";
}

+(NSString*) CanvasZoomState
{
    return @"MSVNotificationSetCanvasZoomState";
}

@end
