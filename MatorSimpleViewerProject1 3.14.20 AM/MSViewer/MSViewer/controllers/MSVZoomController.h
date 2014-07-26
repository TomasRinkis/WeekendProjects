//
//  MSVZoomController.h
//  MSViewer
//
//  Created by Brolis on 7/13/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSVZoomController : UIViewController

@property (weak, nonatomic) IBOutlet UISlider *ZoomSlider;
@property (weak, nonatomic) IBOutlet UILabel *ZoomValueLabel;

- (IBAction)ZoomSliderValueChanged:(UISlider *)sender;

@end