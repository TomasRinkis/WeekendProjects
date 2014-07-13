//
//  MSVZoomController.h
//  MSViewer
//
//  Created by Brolis on 7/13/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSVViewController;
@interface MSVZoomController : UIViewController

@property(nonatomic, weak, readonly) MSVViewController *rootViewController;
@property (weak, nonatomic) IBOutlet UISlider *ZoomSlider;

- (IBAction)ZoomAction:(id)sender;


+ (instancetype) createWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRootController:(MSVViewController*) rootController;

@end
