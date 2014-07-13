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
@class MSVCanvasAbstractElement;

@interface MSVCanvasModel : NSObject<MSVCanvasElementProtocol, MSVCanvasStateProtocol>

@property(weak, nonatomic) MSVCanvasAbstractElement *selectedElement;
@property(strong, nonatomic) NSMutableArray *elementArray;


-(void) addElelemet:(MSVCanvasAbstractElement*) element;
-(void) deleteElement:(MSVCanvasAbstractElement*) element;

-(void) unselectAllElements;

//<factory
+(instancetype) create;

@end
