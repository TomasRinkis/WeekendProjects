//
//  MSVCanvasSelectState.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVCanvasAbstractState.h"

@interface MSVCanvasSelectState : MSVCanvasAbstractState

@end


@interface MSVCanvasSelectState(MSVCanvasSelectStateCreation)

+(instancetype) createWithCanvasModel:(MSVCanvasModel*)canvasModel;

@end