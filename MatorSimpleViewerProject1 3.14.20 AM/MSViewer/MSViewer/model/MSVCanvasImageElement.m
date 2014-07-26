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
#import "MSVShadow.h"

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

-(CIImage*) createScaledShadowImageFromSourceImage:(CIImage*)sourceImage
{
    const float blurRatio = self.shadow.blur;
    
    //Gaussian filter
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [gaussianBlurFilter setValue:sourceImage forKey: @"inputImage"];
    [gaussianBlurFilter setValue:[NSNumber numberWithFloat: blurRatio] forKey: @"inputRadius"];
    CIImage *gausianImage = [gaussianBlurFilter valueForKey: @"outputImage"];
    
    //Croped Gaussian
    CGRect gaussianImageRect = [gausianImage extent];
    CGRect cropImageRect    = CGRectMake(0, 0, gaussianImageRect.size.width - (int)(blurRatio * 6.f), gaussianImageRect.size.height - (int)(blurRatio * 6.f));
    CIImage *croppedGaussianImage = [gausianImage imageByCroppingToRect:cropImageRect];
    
    //<Color generator
    CIFilter* ColorGenerator = [CIFilter filterWithName:@"CIConstantColorGenerator"];
    
    NSString *colorString = [NSString stringWithFormat:@"%0.1f %0.1f %0.1f 1.0", self.shadow.red, self.shadow.green, self.shadow.blue];
    CIColor* color = [CIColor colorWithString:colorString];
    [ColorGenerator setValue:color forKey:@"inputColor"];
    CIImage* colorImage = [ColorGenerator valueForKey:@"outputImage"];
    
    //Blending images
    CIFilter* filterm = [CIFilter filterWithName:@"CIMultiplyCompositing"];
    [filterm setValue:croppedGaussianImage forKey:@"inputImage"];
    [filterm setValue:colorImage forKey:@"inputBackgroundImage"];
    CIImage *blendImage = [filterm valueForKey:@"outputImage"];
    
    return blendImage;
}

-(CGSize)size
{
    const float scale = [MSVScreen scale];
    CGSize imgSize = [self.image extent].size;
    CGSize scaledSize = CGSizeMake(imgSize.width * scale, imgSize.height * scale);
    
    return scaledSize;
}

-(void) drawWithCIContext:(CIContext *)contextCI
{
    //<Get shadow image
    CIImage *shadowImage = [self createScaledShadowImageFromSourceImage:self.image];
    
    //<Get positions
    CGPoint imagePos  = [MSVScreen ciImageSpacePoint:self.pos];
    CGSize  imageSize = CGSizeMake(self.size.width, self.size.height);
    const float scale = [MSVScreen scale];
    
    //1. Draw shadow
    if(self.shadow.on)
    {
        CGPoint offest;
        offest.x = cosf(self.shadow.angle) * self.shadow.offset * scale;
        offest.y = sinf(self.shadow.angle) * self.shadow.offset * scale;
        
        //<Draw cropped shadow image
        CGPoint shadowImagePos = CGPointMake(imagePos.x + offest.x, imagePos.y - offest.y);
        [self drawCroppedImage:shadowImage withContext:contextCI andScale:scale atPos:shadowImagePos];
    }
    
    //2. Draw real image
    //<Draw cropped real image
    [self drawCroppedImage:self.image withContext:contextCI andScale:scale atPos:imagePos];
    
    //3. Draw bounds
    //<Draw bounds
    [self drawBoundsAt:self.pos withSize:imageSize];

    
  //  NSLog(@"pos x: %f  y: %f", self.pos.x, self.pos.y - self.size.height/2.f);
}

-(int) tileIntNumFromFloat:(float)value
{
    float intPart = 0.f;
    float fractPart = modff(value, &intPart);
    
    if(fractPart > 0.0f)
    {
        ++intPart;
    }
    
    return intPart;
}

//should be static, expose logic
-(void) drawCroppedImage:(CIImage*) image withContext:(CIContext*) contextCI andScale:(float)scale atPos:(CGPoint) pos
{
    const CGSize imgSize          = [image extent].size;
    const CGSize imgDesiredSize   = CGSizeMake(imgSize.width * scale, imgSize.height * scale);
    const CGSize imgLimitSize     = [contextCI inputImageMaximumSize];
    
    const int tileHtNum = [self tileIntNumFromFloat:(imgDesiredSize.height/imgLimitSize.height)];
    const int tileWdNum = [self tileIntNumFromFloat:(imgDesiredSize.width/imgLimitSize.width)];
    
    const float tileHt  = imgSize.height/tileHtNum;
    const float tileWd  = imgSize.width/tileWdNum;
    
    const float tileDesiredHt = imgDesiredSize.height/tileHtNum;
    const float tileDesiredWd = imgDesiredSize.width/tileWdNum;
    
    const float scaleHtRatio = tileDesiredHt/tileHt;
    const float scaleWdRatio = tileDesiredWd/tileWd;
    
    for(int c = 0; c < tileHtNum; ++c)
    {
        for (int r = 0; r < tileWdNum; ++r)
        {
            CGPoint offset;
            
            offset.x = tileWd * r;
            offset.y = tileHt * c;
            
            //<crop image
            CGRect cropRect = CGRectMake(offset.x, offset.y, tileWd, tileHt);
            CIImage *croppedImage = [image imageByCroppingToRect:cropRect];
            
            //scale if needed
            CGAffineTransform transform = CGAffineTransformMakeScale(scaleWdRatio, scaleHtRatio);
            
            CIFilter *transformFilter = [CIFilter filterWithName:@"CIAffineTransform"];
            [transformFilter setValue:croppedImage forKey:@"inputImage"];
            [transformFilter setValue:[NSValue valueWithBytes:&transform
                                                     objCType:@encode(CGAffineTransform)]
                               forKey:@"inputTransform"];
            
            CIImage *trasformedImage = [transformFilter valueForKey:@"outputImage"];
            
            //<render cropped image
            CGRect inRect = CGRectMake(pos.x + offset.x * scale, pos.y + offset.y * scale, tileDesiredWd, tileDesiredHt);
            [contextCI drawImage:trasformedImage inRect:inRect fromRect:[trasformedImage extent]];
        }
    }
}


-(void) drawBoundsAt:(CGPoint) point withSize:(CGSize)size
{
    if(self.selected)
    {
        const CGRect selectionRect = CGRectMake(point.x + size.width/2.f, point.y - size.height/2.f, size.width, size.height);
        const CGRect nsSelectionRect = [MSVScreen rectInNS:selectionRect];
        [MSVGraphics drawRect:nsSelectionRect andColor:GLKVector3Make(1.f, 0.f, 0.f)];
    }
}

-(BOOL) intersectsInPos:(CGPoint) pos
{
    //CGSize imgSize = [[self image] extent].size;
    
    const CGSize fatFingerSize = CGSizeMake([MSVScreen fatFingerOffset], [MSVScreen fatFingerOffset]);
    
    CGRect rectA = CGRectMake(pos.x, pos.y, fatFingerSize.width, fatFingerSize.height);
    CGRect rectB = CGRectMake(self.pos.x, self.pos.y - self.size.height, self.size.width, self.size.height);
    //right top
    
    return CGRectIntersectsRect(rectA, rectB);
}

//<factory
+(instancetype) createWithCIImage:(CIImage*) image  atPos:(CGPoint) pos withSize:(CGSize) size;
{
    return [[MSVCanvasImageElement alloc] initWithCIImage:image atPos:pos withSize:size];
}

@end
