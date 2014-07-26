//
//  MSVCanvasModel.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVCanvasElementProtocol.h"
#import "MSVCanvasStateProtocol.h"

//<fowards
@class MSVCanvasImageElement;

@interface MSVCanvasModel : NSObject<MSVCanvasElementProtocol, MSVCanvasStateProtocol>

@property(weak, nonatomic) MSVCanvasImageElement *selectedElement;
@property(strong, nonatomic) NSMutableArray *elementArray;


-(void) tryPerformCropOnSelectedElement;
-(void) addElelemet:(MSVCanvasImageElement*) element;
-(void) deleteElement:(MSVCanvasImageElement*) element;

-(void) unselectAllElements;

-(void) setFloatValue:(float) value forProperty:(NSString*) property;
-(void) setBoolValue:(bool) value forProperty:(NSString*) property;
-(void) setIntValue:(int) value forProperty:(NSString *) property;

@end


@interface MSVCanvasModel(MSVCanvasModelCreation)

+(instancetype) create;

@end