//
//  MSVZoomController.m
//  MSViewer
//
//  Created by Brolis on 7/13/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVZoomController.h"
#import "MSVScreen.h"

@implementation MSVZoomController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.ZoomSlider setMinimumValue:1.f];
    [self.ZoomSlider setMaximumValue:1600.f];
    
    self.ZoomValueLabel.text = [NSString stringWithFormat:@"%d", [self scaleToZoom:[MSVScreen scale]]];
    self.ZoomSlider.value = [self scaleToZoom:[MSVScreen scale]];
}

-(int) scaleToZoom:(float) scale
{
    return scale * 100.f;
}

-(float) zoomToScale:(float) zoom
{
    return zoom/100.f;
}

- (IBAction)ZoomSliderValueChanged:(UISlider *)sender
{
    self.ZoomValueLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    [MSVScreen setScale:[self zoomToScale:sender.value]];
}

@end
