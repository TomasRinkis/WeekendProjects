//
//  DMTestController.h
//  DriskelMator
//
//  Created by Brolis on 5/2/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMTestController : UIViewController

- (IBAction)Type:(UISlider *)sender;
- (IBAction)Red:(UISlider *)sender;
- (IBAction)Green:(UISlider *)sender;
- (IBAction)Blue:(UISlider *)sender;

@property (weak, nonatomic) IBOutlet UISlider *TypeSlider;
@property (weak, nonatomic) IBOutlet UISlider *RedSlider;
@property (weak, nonatomic) IBOutlet UISlider *GreenSlider;
@property (weak, nonatomic) IBOutlet UISlider *BlueSlider;


@property (weak, nonatomic) IBOutlet UILabel *TypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *RedLabel;
@property (weak, nonatomic) IBOutlet UILabel *GreenLabel;
@property (weak, nonatomic) IBOutlet UILabel *BlueLabel;

@end
