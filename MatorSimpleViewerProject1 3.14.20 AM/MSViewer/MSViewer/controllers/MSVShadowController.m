//
//  MSVShadowController.m
//  MSViewer
//
//  Created by Brolis on 7/13/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVShadowController.h"
#import "MSVGraphics.h"

@implementation MSVShadowController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
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
    
    [self.highlightSLider setValue:getShadowHighlightAmount() animated:true];
    [self.shadowSlider setValue:getShadowAmount() animated:true];
    
    self.highlighLabel.text = [NSString stringWithFormat:@"%0.1f", getShadowHighlightAmount()];
    self.shadowLabel.text   = [NSString stringWithFormat:@"%0.1f", getShadowAmount()];
}


- (IBAction)highlighAction:(id)sender
{
    self.highlighLabel.text = [NSString stringWithFormat:@"%0.1f", ((UISlider*)sender).value];
    setShadowHighlightAmount(((UISlider*)sender).value);
}

- (IBAction)shadowAction:(id)sender
{
    self.shadowLabel.text = [NSString stringWithFormat:@"%0.1f", ((UISlider*)sender).value];
    setShadowAmount(((UISlider*)sender).value);
}

@end
