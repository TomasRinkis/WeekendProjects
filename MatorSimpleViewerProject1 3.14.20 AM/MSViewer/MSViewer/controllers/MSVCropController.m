//
//  MSVCropController.m
//  MSViewer
//
//  Created by Brolis on 7/26/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCropController.h"
#import "MSVCanvasModel.h"
#import "MSVCanvasImageElement.h"
#import "MSVScreen.h"
#import "MSVProperties.h"

@implementation MSVCropController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    const float scale = [MSVScreen scale];
    
    //set minimum and maximum
    CIImage *image = self.canvasModel.selectedElement.image;
    CGRect imRect = [image extent];
    CGSize imSize = imRect.size;
    
    imSize.height *= scale;
    imSize.width *= scale;
    
    //<setup slider
    [self.SizeWidthSlider setMinimumValue:0.f];
    [self.SizeWidthSlider setMaximumValue:imSize.width];
    
    [self.SizeHeightSlider setMinimumValue:0.f];
    [self.SizeHeightSlider setMaximumValue:imSize.height];
    
    self.SizeWidthLabel.text = @"0";
    self.SizeHeightLabel.text = @"0";
}

- (IBAction)CropButtonAction:(UIButton *)sender
{
    [self.canvasModel tryPerformCropOnSelectedElement];
}

- (IBAction)SizeWidthSliderValueChanged:(UISlider *)sender
{
    self.SizeWidthLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    [self.canvasModel setIntValue:(int)sender.value forProperty:[MSVProperties CropWidth]];
}

- (IBAction)SizeHeightValueChanged:(UISlider *)sender
{
    self.SizeHeightLabel.text = [NSString stringWithFormat:@"%d", (int)sender.value];
    [self.canvasModel setIntValue:(int)sender.value forProperty:[MSVProperties CropHeight]];
}

@end