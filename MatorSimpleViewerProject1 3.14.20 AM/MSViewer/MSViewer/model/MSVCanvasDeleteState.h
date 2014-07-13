//
//  MSVCanvasDeleteState.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVCanvasAbstractState.h"

@interface MSVCanvasDeleteState : MSVCanvasAbstractState

+(instancetype) createWithCanvasModel:(MSVCanvasModel*)canvasModel;

@end
