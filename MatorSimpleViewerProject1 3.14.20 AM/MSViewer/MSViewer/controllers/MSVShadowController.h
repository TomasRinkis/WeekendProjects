//
//  MSVShadowController.h
//  MSViewer
//
//  Created by Brolis on 7/13/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSVAnglePickerView;
@class MSVCanvasModel;

@interface MSVShadowController : UIViewController

@property(weak, nonatomic) MSVCanvasModel *canvasModel;

@property (weak, nonatomic) IBOutlet UILabel *RedValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *GreenValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *BlueValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *OffsetValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *BlurValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *AngleValueLabel;

@property (weak, nonatomic) IBOutlet UISlider *RedValueSlider;
@property (weak, nonatomic) IBOutlet UISlider *GreenValueSlider;
@property (weak, nonatomic) IBOutlet UISlider *BlueValueSlider;

@property (weak, nonatomic) IBOutlet UISlider *OffsetSlider;
@property (weak, nonatomic) IBOutlet UISlider *BlurSlider;

@property (weak, nonatomic) IBOutlet MSVAnglePickerView *AnglePickerView;
@property (weak, nonatomic) IBOutlet UISwitch *ShadowSwitch;


- (IBAction)RedSliderValueChanged:(UISlider *)sender;
- (IBAction)GreenSliderValueChanged:(UISlider *)sender;
- (IBAction)BlueSliderValueChanged:(UISlider *)sender;

- (IBAction)OffsetSliderValueChanged:(UISlider *)sender;
- (IBAction)BlurSliderValueChanged:(UISlider *)sender;

- (IBAction)AnglePickerValueChanged:(MSVAnglePickerView *)sender;
- (IBAction)ShadowSwitchValue:(UISwitch *)sender;


@end
