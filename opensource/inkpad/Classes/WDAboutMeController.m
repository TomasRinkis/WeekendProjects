//
//  WDAboutMenController.m
//  Inkpad
//
//  Created by Brolis on 6/14/14.
//  Copyright (c) 2014 Taptrix, Inc. All rights reserved.
//

#import "WDAboutMeController.h"

@implementation WDAboutMeController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (!self)
    {
        return nil;
    }
    
    NSString *version = [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleVersionKey];
    
    // don't need to localize the app name
    self.navigationItem.title = [NSString stringWithFormat:@"Inkpad %@", version];
    

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                              target:self
                                              action:@selector(dismissView:)];
    return self;
}

- (NSURL *) aboutMeURL
{
    NSString *resource = NSLocalizedString(@"aboutMe", @"Name of About me html file");
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"html" inDirectory:@"Help"];
    return [NSURL fileURLWithPath:path isDirectory:NO];
}

- (void)loadView
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view = webView;
    [webView loadRequest:[NSURLRequest requestWithURL:[self aboutMeURL]]];
}

- (void)dismissView:(id)sender
{
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

+(instancetype) createWithNibName:(NSString*)nibNameOrNil andBundle:(NSBundle*)nibBundleOrNil
{
    return [[WDAboutMeController alloc] initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
}
@end
