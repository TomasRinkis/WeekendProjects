//
//  MSVMSVCanvasStateProtocol.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MSVCanvasStateProtocol <NSObject>

@required

- (void)touchesBeganInPos:(CGPoint) pos;
- (void)touchesMovedInPos:(CGPoint) pos;
- (void)touchesEndedInPos:(CGPoint) pos;
- (void)touchesCancelledInPos:(CGPoint) pos;
- (void)drawSelection;

@optional

@end
