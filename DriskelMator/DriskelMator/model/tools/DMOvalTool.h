//
//  DMOvalTool.h
//  DriskelMator
//
//  Created by Brolis on 5/2/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMAbsractTool.h"

@interface DMOvalTool : DMAbsractTool

+(instancetype) createWithFrame:(CGRect) frame andCanvasState:(DMAbstarctState*) canvasState;

@end