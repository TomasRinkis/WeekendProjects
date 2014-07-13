//
//  MSVZoomController.m
//  MSViewer
//
//  Created by Brolis on 7/13/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVZoomController.h"
#import "MSVViewController.h"

//<state
float _zoomFacotor = 0.f;

@implementation MSVZoomController

@synthesize rootViewController = _rootViewController;

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRootController:(MSVViewController*) rootController
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self)
    {
        _rootViewController = rootController;
    }
    return self;
}

+ (instancetype) createWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andRootController:(MSVViewController*) rootController
{
    return [[MSVZoomController alloc] initWithNibName:nibNameOrNil bundle:nibBundleOrNil andRootController:rootController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.ZoomSlider setValue:_zoomFacotor animated:true];
    
}

- (IBAction)ZoomAction:(id)sender
{
    _zoomFacotor = (((UISlider*)sender).value);
    [_rootViewController scaleToolView:_zoomFacotor];
}

@end
