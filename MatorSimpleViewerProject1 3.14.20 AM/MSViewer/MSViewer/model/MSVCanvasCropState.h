//
//  MSVCanvasCropState.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVCanvasAbstractState.h"

@interface MSVCanvasCropState : MSVCanvasAbstractState

+(instancetype) createWithCanvasModel:(MSVCanvasModel*)canvasModel;

@end
