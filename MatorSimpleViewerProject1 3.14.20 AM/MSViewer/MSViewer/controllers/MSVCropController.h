//
//  MSVCropController.h
//  MSViewer
//
//  Created by Brolis on 7/26/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSVCanvasModel;

@interface MSVCropController : UIViewController
@property (weak, nonatomic) MSVCanvasModel *canvasModel;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *SizeWidthLabel;
@property (weak, nonatomic) IBOutlet UILabel *SizeHeightLabel;

//Sliders
@property (weak, nonatomic) IBOutlet UISlider *SizeWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *SizeHeightSlider;

- (IBAction)SizeWidthSliderValueChanged:(UISlider *)sender;
- (IBAction)SizeHeightValueChanged:(UISlider *)sender;


//Buttons
- (IBAction)CropButtonAction:(UIButton *)sender;

@end