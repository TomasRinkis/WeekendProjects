//
//  DMTestController.m
//  DriskelMator
//
//  Created by Brolis on 5/2/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <GLKit/GLKVector4.h>

#import "DMTestController.h"
#import "DMCanvas.h"

const char* const chTypes[] =
{
    "Bla",
    "Tba",
    "Kra"
};

@interface DMTestController ()
{
    GLKVector4 _background;
}
@end

@implementation DMTestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        _background = GLKVector4Make(0.0, 0.0, 0.0, 0.0);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    GLKVector4 vec4 = [[DMCanvas sharedInstance] background];
    
    [self.TypeSlider setValue:vec4.a animated:true];
    [self.RedSlider setValue:vec4.r animated:true];
    [self.GreenSlider setValue:vec4.g animated:true];
    [self.BlueSlider setValue:vec4.b animated:true];
    
    self.TypeLabel.text = [NSString stringWithFormat:@"%0.1f", vec4.a];
    self.RedLabel.text = [NSString stringWithFormat:@"%0.1f", vec4.r];
    self.GreenLabel.text = [NSString stringWithFormat:@"%0.1f", vec4.g];
    self.BlueLabel.text = [NSString stringWithFormat:@"%0.1f", vec4.b];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Type:(UISlider *)sender
{
    //
//    NSLog(@"%f", sender.value);
    
    self.TypeLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];

    _background.a = sender.value;
    [DMCanvas sharedInstance].background = _background;
}

- (IBAction)Red:(UISlider *)sender
{
    //    NSLog(@"%f", sender.value);
    self.RedLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];

    _background.r = sender.value;
    [DMCanvas sharedInstance].background = _background;
}

- (IBAction)Green:(UISlider *)sender
{
    //NSLog(@"%f", sender.value);
    self.GreenLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];

    _background.g = sender.value;
    [DMCanvas sharedInstance].background = _background;
}

- (IBAction)Blue:(UISlider *)sender
{
    //NSLog(@"%f", sender.value);
    self.BlueLabel.text = [NSString stringWithFormat:@"%0.1f", sender.value];

    _background.b = sender.value;
    [DMCanvas sharedInstance].background = _background;
}

@end
