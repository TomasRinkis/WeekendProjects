//
//  MSVCanvasZoomState.h
//  MSViewer
//
//  Created by Brolis on 7/23/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVCanvasAbstractState.h"

@interface MSVCanvasZoomState : MSVCanvasAbstractState

@end


@interface MSVCanvasZoomState(MSVCanvasZoomStateCreation)

+(instancetype) createWithCanvasModel:(MSVCanvasModel*)canvasModel;

@end