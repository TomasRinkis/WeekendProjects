//
//  DMAbtractElement.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKMathTypes.h>
#import "DMUIProtocol.h"

@interface DMAbtractElement : NSObject

@property(nonatomic) CGRect dirtyBBox;
@property(nonatomic) CGRect debugBBox;
@property(nonatomic, readonly) GLKMatrix4 transform;

@property(nonatomic) GLKMatrix4 rotation;
@property(nonatomic) GLKMatrix4 translation;

@property(nonatomic, readonly) GLKVector2 position;
@property(nonatomic, readonly) float rotAngle;


@property(nonatomic) BOOL selected;

-(id) initWithBBox:(CGRect) bbox translation:(GLKMatrix4) translation andRotation:(GLKMatrix4)rotation;
-(void) dump;

-(void) draw;

-(BOOL) intersectsWithPoint:(GLKVector2)point;

@end
