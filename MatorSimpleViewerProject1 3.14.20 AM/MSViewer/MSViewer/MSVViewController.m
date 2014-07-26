//
//  DMViewController.m
//  DriskelMator
//
//  Created by Brolis on 4/13/14.
//  Copyright (c) 2014 DM. All rights reserved.
//


#import "MSVViewController.h"

#import "MSVShadowController.h"
#import "MSVScreen.h"
#import "MSVGraphics.h"
#import "MSVCanvasImageElement.h"
#import "MSVToolsInventoryView.h"
#import "MSVToolsInventoryController.h"
#import "MSVToolInventory.h"
#import "MSVZoomController.h"
#import "MSVCropController.h"
#import "MSVNotifications.h"
#import "MSVCanvasModel.h"

#import "MSVCanvasController.h"
#import "MSVShaderConstants.h"
#import "MSVShaderContainer.h"

//<frameworks
#import <CoreImage/CoreImage.h>

@interface MSVViewController ()
{
    EAGLContext *_contextEAGL;
    CIContext   *_contextCI;
    
    MSVToolsInventoryView *_toolView;
    MSVToolsInventoryController *_toolViewController;
    MSVZoomController *_zoomController;
    MSVShadowController *_shadowController;
    MSVCropController *_cropController;
    UIPopoverController *_popoverController;
    
    MSVCanvasController *_canvasController;
    GLKView *_canvasView;
    
    UIBarButtonItem *_zoomItem;
    UIBarButtonItem *_shadowFilterItem;
    UIBarButtonItem *_cropItem;
    UIBarButtonItem *_photoAlbumItem;
}

- (void)setupGL;
- (void)tearDownGL;

@end

@implementation MSVViewController

-(instancetype) init
{
    self = [super init];
    
    if(self)
    {
        _canvasController = nil;
        _canvasView = nil;
        
        _contextEAGL = nil;
        _contextCI  = nil;
        
        _toolView = nil;
        _toolViewController = nil;
        _popoverController = nil;
        _shadowController = nil;
        _zoomController = nil;
        _cropController = nil;
    }
    
    return self;
}

- (void)dealloc
{
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == _contextEAGL)
    {
        [EAGLContext setCurrentContext:nil];
    }
    
    _canvasController = nil;
    _canvasView = nil;
    
    _contextEAGL = nil;
    _contextCI  = nil;
    
    _toolView = nil;
    _toolViewController = nil;
    _popoverController = nil;
    _shadowController = nil;
    _zoomController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupContext];
    [self setupGL];
    [self setupShaderGraphics];
    
    [self setupSubViews];
    [self setupNotifications];
}

-(void) setupContext
{
    _contextEAGL = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    NSDictionary *options = @{ kCIContextWorkingColorSpace : [NSNull null] };
    _contextCI = [CIContext contextWithEAGLContext:_contextEAGL
                                           options:options];
    
    if (!_contextEAGL || !_contextCI)
    {
        NSLog(@"Failed initilize contexts!!");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = _contextEAGL;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    self.preferredFramesPerSecond = 60;
    self.paused = NO;
}

-(void) setupShaderGraphics
{
    [MSVScreen initWithScreenBounds:self.view.bounds];
    [MSVGraphics init];
    [MSVGraphics loadDefaultMatrixes];
}

-(void) setupNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleZoomStateNotification:)
                                                 name:[MSVNotification CanvasZoomState]
                                               object:nil];
}

-(void) setupSubViews
{
    [self setupCanvasSubView];
    [self setupToolSubView];
    [self setupToolBarSubView];
}

-(void) setupToolSubView
{
    _toolView = [MSVToolsInventoryView createWithFrame:CGRectMake(20.f, 50.f, 60.f, 400.f)];
    _toolViewController = [MSVToolsInventoryController createWithView:_toolView];
    [self.view addSubview:_toolView];
    
    [[MSVToolInventory sharedInstance] fillToolButtonsInView:_toolView];
}

-(void) setupCanvasSubView
{
    _canvasView = [[GLKView alloc] initWithFrame:self.view.bounds context:_contextEAGL];
    _canvasController = [MSVCanvasController createWithGLKView:_canvasView];
    [self.view addSubview:_canvasView];
}

-(void) setupToolBarSubView
{
    //<tool bar
    _photoAlbumItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Photo Album", @"Photo Album")
                                                       style:UIBarButtonItemStyleDone
                                                      target:self
                                                      action:@selector(openPhotoAlbum:)];
    
    
    _shadowFilterItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Shadow Filter", @"Shadow Filter")
                                                         style:UIBarButtonItemStyleDone
                                                        target:self
                                                        action:@selector(openShadowFilter:)];
    
    _zoomItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Zoom", @"Zoom")
                                                 style:UIBarButtonItemStyleDone
                                                target:self
                                                action:@selector(openZoomWindow:)];
    
    
    
    _cropItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Crop", @"Crop")
                                                 style:UIBarButtonItemStyleDone
                                                target:self
                                                action:@selector(openCropWindow:)];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects: _photoAlbumItem, _shadowFilterItem, _zoomItem, _cropItem, nil];
    
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 1024-50, 768, 50)];
    
    [toolbar setBarStyle:UIBarStyleBlackOpaque];
    [self.view addSubview:toolbar];
    [toolbar setItems:toolbarItems];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil))
    {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == _contextEAGL)
        {
            [EAGLContext setCurrentContext:nil];
        }
        _contextEAGL = nil;
        _contextCI = nil;
    }
    
    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:_contextEAGL];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    UITouch * touch     = (UITouch*)[touches anyObject];
    //    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    UITouch * touch     = (UITouch*)[touches anyObject];
    //    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //    UITouch * touch     = (UITouch*)[touches anyObject];
    //    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
    //    UITouch * touch     = (UITouch*)[touches anyObject];
    //    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
}

#pragma mark tool bar items
-(void) openPhotoAlbum:(id)sender
{
    UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
    
    pickerC.delegate = self;
    [self presentViewController:pickerC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *uiImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    CIImage *ciImage = [CIImage imageWithCGImage:uiImage.CGImage];
    
    const CGRect extentRect = [ciImage extent];
    
    const CGPoint imageElementPos = [MSVScreen centerPoint];
    const CGSize imageElementSize = extentRect.size;
    
    MSVCanvasImageElement *imageElement = [MSVCanvasImageElement createWithCIImage:ciImage atPos:imageElementPos withSize:imageElementSize];
    [_canvasController.canvasModel addElelemet:imageElement];
    
    //<some unknown hack it will pause controller :(
    self.paused = NO;
}

- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) openShadowFilter:(id)sender
{
    if(_canvasController.canvasModel.selectedElement)
    {
        _shadowController = [[MSVShadowController alloc] initWithNibName:@"MSVShadow" bundle:nil];
        _shadowController.canvasModel = _canvasController.canvasModel;
        
        _popoverController = [[UIPopoverController alloc] initWithContentViewController:_shadowController];
        [_popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
        [[MSVToolInventory sharedInstance] pressButtonWithType:MSVToolTypeSelect];
    }
    else
    {
        [self showSelectElementAlertView];
    }
}

-(void) handleZoomStateNotification:(NSNotification *)aNotification
{
    [self openZoomWindow:_zoomItem];
}

-(void) openZoomWindow:(id)sender
{
    _zoomController = [[MSVZoomController alloc]initWithNibName:@"MSVZoom" bundle:nil];
    
    _popoverController = [[UIPopoverController alloc] initWithContentViewController:_zoomController];
    [_popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
    [[MSVToolInventory sharedInstance] pressButtonWithType:MSVToolTypeSelect];
}

-(void) openCropWindow:(id)sender
{
    if(_canvasController.canvasModel.selectedElement)
    {
        _cropController = [[MSVCropController alloc]initWithNibName:@"MSVCrop" bundle:nil];
        _cropController.canvasModel = _canvasController.canvasModel;
        
        _popoverController = [[UIPopoverController alloc] initWithContentViewController:_cropController];
        [_popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:[MSVNotification CanvasCropState] object:self];
    }
    else
    {
        [self showSelectElementAlertView];
    }
}

-(void) showSelectElementAlertView
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Info", @"Info")
                                                    message:NSLocalizedString(@"Please select an image", @"Please select an image")
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Ok", @"Ok")
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - GLKView and GLKViewController delegate methods
- (void)update
{
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
}

@end
