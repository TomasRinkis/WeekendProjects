//
//  MSVCanvasAbstractState.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSVCanvasStateProtocol.h"

@class MSVCanvasModel;

@interface MSVCanvasAbstractState : NSObject<MSVCanvasStateProtocol>

@property (nonatomic) CGPoint touchBeginPos;
@property (nonatomic) CGPoint touchMovePos;

@property (weak, nonatomic) MSVCanvasModel *canvasModel;

-(instancetype) initWithCanvasModel:(MSVCanvasModel*) canvasModel;

@end
