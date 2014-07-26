//
//  MSVCrop.h
//  MSViewer
//
//  Created by Brolis on 7/26/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSVCrop : NSObject

@property (nonatomic) int width;
@property (nonatomic) int height;
@property (nonatomic, readonly) CGSize size;

@end

@interface MSVCrop(MSVCropCreation)

+(instancetype) createWithHeight:(int) height andWidth:(int) width;

@end
