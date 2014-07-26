//
//  MSVCanvasController.h
//  MSViewer
//
//  Created by Brolis on 7/23/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@class MSVCanvasModel;

@interface MSVCanvasController : GLKViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic, strong, readonly) MSVCanvasModel *canvasModel;

@end



@interface MSVCanvasController(MSVCanvasControllerCreation)

+(instancetype) createWithGLKView:(GLKView*) glView;

@end