//
//  MSVCanvasAbstractElement.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasAbstractElement.h"
#import "MSVScreen.h"
#import "MSVShadow.h"
#import "MSVCrop.h"
#import "MSVProperties.h"

@implementation MSVCanvasAbstractElement

@synthesize pos     = _pos;
@synthesize size    = _size;
@synthesize selected= _selected;

-(instancetype) init
{
    self = [super init];
    
    if(self)
    {
        self.pos    = CGPointZero;
        self.size   = CGSizeZero;
        self.selected = FALSE;
        
        self.shadow = [MSVShadow create];
        self.crop   = [MSVCrop createWithHeight:0 andWidth:0];
    }
    
    return self;
}

-(instancetype) initWithPos:(CGPoint) pos andSize:(CGSize) size
{
    self = [super init];
    
    if(self)
    {
        self.pos    = pos;
        self.size   = size;
        
        self.shadow = [MSVShadow create];
        self.crop   = [MSVCrop createWithHeight:0 andWidth:0];
    }
    
    return self;
}

-(void) drawWithCIContext:(CIContext *)contextCI
{
    [NSException raise:@"Invalid implementation" format:@"%@ implement in supper class!", NSStringFromClass([self class])];
}

-(BOOL) intersectsInPos:(CGPoint) pos
{
    const CGSize fatFingerSize = CGSizeMake([MSVScreen fatFingerOffset], [MSVScreen fatFingerOffset]);
    
    CGRect rectA = CGRectMake(pos.x, pos.y, fatFingerSize.width, fatFingerSize.height);
    CGRect rectB = CGRectMake(self.pos.x, self.pos.y, self.size.width, self.size.height);
    
    return CGRectIntersectsRect(rectA, rectB);
}

-(void) setFloatValue:(float)value forProperty:(NSString *)property
{
    if([property isEqualToString:[MSVProperties ShadowRed]])
    {
        self.shadow.red = value;
    }
    else if([property isEqualToString:[MSVProperties ShadowGreen]])
    {
        self.shadow.green = value;
    }
    else if([property isEqualToString:[MSVProperties ShadowBlue]])
    {
        self.shadow.blue = value;
    }
    else if([property isEqualToString:[MSVProperties ShadowAngle]])
    {
        self.shadow.angle = value;
    }
    else if([property isEqualToString:[MSVProperties ShadowOffset]])
    {
        self.shadow.offset = value;
    }
    else if([property isEqualToString:[MSVProperties ShadowBlur]])
    {
        self.shadow.blur = value;
    }
}

-(void) setBoolValue:(bool)value forProperty:(NSString *)property
{
    if([property isEqualToString:[MSVProperties ShadowOn]])
    {
        self.shadow.on = value;
    }
}

-(void) setIntValue:(int) value forProperty:(NSString *) property
{
    if([property isEqualToString:[MSVProperties CropWidth]])
    {
        self.crop.width = value;
    }
    else if([property isEqualToString:[MSVProperties CropHeight]])
    {
        self.crop.height = value;
    }
}

@end
