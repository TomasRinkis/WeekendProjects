//
//  MSVCanvasAbstractElement.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVCanvasElementProtocol.h"

@class MSVShadow;
@class MSVCrop;

@interface MSVCanvasAbstractElement : NSObject<MSVCanvasElementProtocol>

@property (nonatomic) CGPoint pos;
@property (nonatomic) CGSize size;
@property (nonatomic) BOOL selected;

@property (nonatomic, strong) MSVShadow *shadow;
@property (nonatomic, strong) MSVCrop *crop;

-(BOOL) intersectsInPos:(CGPoint) pos;

-(void) setFloatValue:(float)value forProperty:(NSString *)property;
-(void) setBoolValue:(bool)value forProperty:(NSString *)property;
-(void) setIntValue:(int) value forProperty:(NSString *) property;

@end


@interface MSVCanvasAbstractElement(MSVCanvasAbstractElementCreation)

-(instancetype) initWithPos:(CGPoint) pos andSize:(CGSize) size;

@end

