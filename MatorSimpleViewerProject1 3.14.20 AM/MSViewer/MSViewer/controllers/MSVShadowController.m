//
//  MSVShadowController.m
//  MSViewer
//
//  Created by Brolis on 7/13/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVShadowController.h"
#import "MSVGraphics.h"
#import "MSVAnglePickerView.h"
#import "MSVCanvasModel.h"
#import "MSVProperties.h"
#import "MSVShadow.h"
#import "MSVCanvasImageElement.h"

#import <GLKit/GLKit.h>

@implementation MSVShadowController

@synthesize canvasModel = _canvasModel;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.BlurSlider setMinimumValue:0.f];
    [self.BlurSlider setMaximumValue:10.f];
    
    [self.OffsetSlider setMinimumValue:0.f];
    [self.OffsetSlider setMaximumValue:40.f];
    
    //load from selected element
    MSVShadow *shadow = self.canvasModel.selectedElement.shadow;
    
    //<labels
    self.RedValueLabel.text = [NSString stringWithFormat:@"%0.1f", shadow.red];
    self.GreenValueLabel.text = [NSString stringWithFormat:@"%0.1f", shadow.green];
    self.BlueValueLabel.text = [NSString stringWithFormat:@"%0.1f", shadow.blue];
    
    self.OffsetValueLabel.text = [NSString stringWithFormat:@"%0.1f", shadow.offset];
    self.BlurValueLabel.text = [NSString stringWithFormat:@"%0.1f", shadow.blur];
    
    self.AngleValueLabel.text = [NSString stringWithFormat:@"%0.1f", shadow.angle];
    
    //<sliders
    self.RedValueSlider.value = shadow.red;
    self.GreenValueSlider.value = shadow.green;
    self.BlueValueSlider.value = shadow.blue;
    
    self.OffsetSlider.value = shadow.offset;
    self.BlurSlider.value = shadow.blur;
 
    self.ShadowSwitch.on = shadow.on;
    
    
    self.AnglePickerView.value = shadow.angle;
}

- (IBAction)RedSliderValueChanged:(UISlider *)sender
{
    self.RedValueLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
    [self.canvasModel setFloatValue:sender.value forProperty:[MSVProperties ShadowRed]];
}

- (IBAction)GreenSliderValueChanged:(UISlider *)sender
{
    self.GreenValueLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
    [self.canvasModel setFloatValue:sender.value forProperty:[MSVProperties ShadowGreen]];
}

- (IBAction)BlueSliderValueChanged:(UISlider *)sender
{
    self.BlueValueLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
    [self.canvasModel setFloatValue:sender.value forProperty:[MSVProperties ShadowBlue]];
}

- (IBAction)OffsetSliderValueChanged:(UISlider *)sender
{
    self.OffsetValueLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
    [self.canvasModel setFloatValue:sender.value forProperty:[MSVProperties ShadowOffset]];
}

- (IBAction)BlurSliderValueChanged:(UISlider *)sender
{
    self.BlurValueLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
    [self.canvasModel setFloatValue:sender.value forProperty:[MSVProperties ShadowBlur]];
}

- (IBAction)AnglePickerValueChanged:(MSVAnglePickerView *)sender
{
    self.AngleValueLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];
    [self.canvasModel setFloatValue:sender.value forProperty:[MSVProperties ShadowAngle]];
}

- (IBAction)ShadowSwitchValue:(UISwitch *)sender
{
    [self.canvasModel setBoolValue:sender.on forProperty:[MSVProperties ShadowOn]];
}

@end
