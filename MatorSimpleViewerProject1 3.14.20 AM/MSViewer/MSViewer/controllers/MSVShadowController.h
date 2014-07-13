//
//  MSVShadowController.h
//  MSViewer
//
//  Created by Brolis on 7/13/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSVShadowController : UIViewController


@property (weak, nonatomic) IBOutlet UISlider *highlightSLider;
@property (weak, nonatomic) IBOutlet UISlider *shadowSlider;

- (IBAction)highlighAction:(id)sender;
- (IBAction)shadowAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *highlighLabel;
@property (weak, nonatomic) IBOutlet UILabel *shadowLabel;

@end
