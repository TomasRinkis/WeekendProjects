//
//  MSVCanvasImageElement.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasAbstractElement.h"

@interface MSVCanvasImageElement : MSVCanvasAbstractElement

@property(strong, nonatomic, readonly) CIImage *image;

@end


@interface MSVCanvasImageElement(MSVCanvasImageElementCreation)

+(instancetype) createWithCIImage:(CIImage*) image atPos:(CGPoint) pos withSize:(CGSize) size;
@end
