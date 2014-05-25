//
//  DMViewController.m
//  DriskelMator
//
//  Created by Brolis on 4/13/14.
//  Copyright (c) 2014 DM. All rights reserved.
//


#import "DMViewController.h"
#import "DMGraphics.h"
#import "DMScreen.h"
#import "DMCanvas.h"
#import "DMToolPalleteController.h"
#import "DMToolsPalleteVIew.h"
#import "DMToolInventory.h"
#import "DMCanvas.h"
#import "DMTestController.h"

@interface DMViewController ()
{
    DMToolPalleteController *_toolPaleteController;
    DMToolsPalleteVIew  *_toolPaleteView;
    UIPopoverController *popoverController_;
    DMTestController *testController;
}
@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;


- (void)setupGL;
- (void)tearDownGL;

@end

@implementation DMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context)
    {
        NSLog(@"Failed to create ES context");
    }
    
    _toolPaleteView = [DMToolsPalleteVIew createWithFrame:CGRectMake(20.f, 50.f, 30.f, 200.f)];
    _toolPaleteController = [DMToolPalleteController createWithView:_toolPaleteView];
    _toolPaleteView.controllerDelegate = _toolPaleteController;
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [DMCanvas sharedInstance];
    
    [[DMToolInventory sharedInstance] fillView:_toolPaleteView];
    [view addSubview:_toolPaleteView];
    
    self.preferredFramesPerSecond = 60;
    self.paused = NO;
    
    [self setupGL];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *customItem2 = [[UIBarButtonItem alloc] initWithTitle:@"Background" style:UIBarButtonItemStyleDone target:self action:@selector(showLayers:)];
    NSArray *toolbarItems = [NSArray arrayWithObjects: spaceItem,spaceItem, customItem2, nil];
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 1024-50, 768, 50)];
    
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    [self.view addSubview:toolbar];
    [toolbar setItems:toolbarItems];
}

-(void) showLayers:(id)sender
{
    testController = [[DMTestController alloc] initWithNibName:@"DMTestController" bundle:nil];
    
    popoverController_ = [[UIPopoverController alloc] initWithContentViewController:testController];
    [popoverController_ presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)dealloc
{
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context)
    {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil))
    {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context)
        {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
    
    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [DMScreen initWithScreenBounds:self.view.bounds];
    [DMGraphics init];
    [DMGraphics loadDefaultMatrixes];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    [DMGraphics tearDown];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    GLKVector2 pos      = [DMScreen convertUITouchEventToNS:touch];
    
    [[DMCanvas sharedInstance] touchesBegan:touches inPos:pos];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    GLKVector2 pos      = [DMScreen convertUITouchEventToNS:touch];
    
    [[DMCanvas sharedInstance] touchesMoved:touches inPos:pos];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    GLKVector2 pos      = [DMScreen convertUITouchEventToNS:touch];
    
    [[DMCanvas sharedInstance] touchesEnded:touches inPos:pos];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    GLKVector2 pos      = [DMScreen convertUITouchEventToNS:touch];
    
    [[DMCanvas sharedInstance] touchesCancelled:touches inPos:pos];
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    [[DMCanvas sharedInstance] update];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [[DMCanvas sharedInstance] draw];
    
    //[DMGraphics drawSolidQuadAt:CGPointMake(0.f, 0.f) withSize:CGSizeMake(0.5f, 0.5f)];
}
@end
