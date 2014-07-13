//
//  MSVCanvasElementProtocol.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSVCanvasElementProtocol <NSObject>

@required
-(void) drawWithCIContext:(CIContext*) contextCI;

@optional

@end
