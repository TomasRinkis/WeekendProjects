//
//  MSVViewController.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@interface MSVViewController : GLKViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

-(void) scaleToolView:(float) scale;

@end
