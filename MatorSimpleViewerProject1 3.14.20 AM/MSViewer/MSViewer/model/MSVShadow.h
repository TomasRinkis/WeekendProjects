//
//  MSVShadow.h
//  MSViewer
//
//  Created by Brolis on 7/24/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 Simple hold shadow state
 */
@interface MSVShadow : NSObject

@property(nonatomic) float red;
@property(nonatomic) float green;
@property(nonatomic) float blue;

@property(nonatomic) float angle;
@property(nonatomic) float offset;
@property(nonatomic) float blur;

@property(nonatomic) bool on;

@end


@interface MSVShadow(MSVShadowCreation)

+(instancetype) create;

@end