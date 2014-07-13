//
//  MSVCanvasImageElement.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasImageElement.h"
#import "MSVScreen.h"
#import "MSVGraphics.h"
#import "MSVShaderContainer.h"
#import "MSVShaderConstants.h"

#include <GLKit/GLKit.h>

@implementation MSVCanvasImageElement

@synthesize image = _image;

-(instancetype) initWithCIImage:(CIImage*) image atPos:(CGPoint) pos withSize:(CGSize) size;
{
    self = [super initWithPos:pos andSize:size];
    
    if(self)
    {
        _image = image;
    }
    
    return self;
}

-(CIImage*) shadowFilteredImageFromImage:(CIImage*)image
{
    CIFilter *shadowFilter = [CIFilter filterWithName:@"CIHighlightShadowAdjust"
                                  keysAndValues:
                              kCIInputImageKey, image,
                              @"inputHighlightAmount", [NSNumber numberWithFloat:getShadowHighlightAmount()],
                              @"inputShadowAmount", [NSNumber numberWithFloat:getShadowAmount()], nil];
    
    return [shadowFilter outputImage];
}

-(void) drawWithCIContext:(CIContext *)contextCI
{
    CGPoint ciImagePos  = [MSVScreen ciImageSpacePoint:self.pos];
    CGSize  ciImageSize = CGSizeMake(self.size.width, self.size.height);
    
    ciImagePos = [MSVScreen scaledPoint:ciImagePos];
    ciImageSize = [MSVScreen scaledSize:ciImageSize];
    
    CGRect inRect = CGRectMake(ciImagePos.x, ciImagePos.y, ciImageSize.width, ciImageSize.height);
    
    CIImage *shadowImage = [self shadowFilteredImageFromImage: self.image];
    [contextCI drawImage:shadowImage inRect:inRect fromRect:[self.image extent]];
    
    [self drawBoundsAt:ciImagePos withSize:ciImageSize];
}

-(void) drawBoundsAt:(CGPoint) point withSize:(CGSize)size
{
    MSVShaderProgram *primitiveShader =  [[MSVShaderContainer sharedInstance] getShaderProgramFromName:[MSVShaderConstants primitiveShaderName]];
    [MSVGraphics setShaderProgram:primitiveShader];
    
   if(self.selected)
    {
        CGPoint nsPoint = [MSVScreen pointInNS:point];
        CGSize nsSize   = [MSVScreen sizeInNS:size];
        
        CGRect rect = CGRectMake(nsPoint.x + nsSize.width/2.f, -(nsPoint.y - nsSize.height/2.f), nsSize.width, nsSize.height);
        [MSVGraphics drawRect:rect andColor:GLKVector3Make(1.f, 0.f, 0.f)];
    }
}

-(BOOL) intersectsInPos:(CGPoint) pos
{
    const CGSize fatFingerSize = CGSizeMake([MSVScreen fatFingerOffset], [MSVScreen fatFingerOffset]);
    
    CGRect rectA = CGRectMake(pos.x, pos.y, fatFingerSize.width, fatFingerSize.height);
    CGRect rectB = CGRectMake(self.pos.x, self.pos.y - self.size.height, self.size.width, self.size.height);
    
    return CGRectIntersectsRect(rectA, rectB);
}

//<factory
+(instancetype) createWithCIImage:(CIImage*) image  atPos:(CGPoint) pos withSize:(CGSize) size;
{
    return [[MSVCanvasImageElement alloc] initWithCIImage:image atPos:pos withSize:size];
}

@end
