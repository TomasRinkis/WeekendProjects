//
//  MSVNotifications.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSVNotification : NSObject

+(NSString*) CanvasSelectState;
+(NSString*) CanvasCropState;
+(NSString*) CanvasDeleteState;
+(NSString*) CanvasZoomState;

@end
