//
//  MSVCanvasAbstractElement.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVCanvasElementProtocol.h"

@interface MSVCanvasAbstractElement : NSObject<MSVCanvasElementProtocol>

@property (nonatomic) CGPoint pos;
@property (nonatomic) CGSize size;
@property (nonatomic) BOOL selected;

-(instancetype) initWithPos:(CGPoint) pos andSize:(CGSize) size;
-(BOOL) intersectsInPos:(CGPoint) pos;

@end
