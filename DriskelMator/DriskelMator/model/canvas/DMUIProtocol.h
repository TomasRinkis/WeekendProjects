//
//  DMCanvasProtocol.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKVector2.h>

@protocol DMUIProtocol <NSObject>

- (void)touchesBegan:(NSSet *)touches inPos:(GLKVector2) pos;
- (void)touchesMoved:(NSSet *)touches inPos:(GLKVector2) pos;
- (void)touchesEnded:(NSSet *)touches inPos:(GLKVector2) pos;
- (void)touchesCancelled:(NSSet *)touches inPos:(GLKVector2) pos;

- (void)update;
- (void)draw;


@end
