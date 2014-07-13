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
#import "MSVCanvasModel.h"
#import "MSVCanvasImageElement.h"
#import "MSVToolsInventoryView.h"
#import "MSVToolsInventoryController.h"
#import "MSVToolInventory.h"
#import "MSVZoomController.h"

#import "MSVShaderConstants.h"
#import "MSVShaderContainer.h"

//<frameworks
#import <CoreImage/CoreImage.h>

@interface MSVViewController ()
{
    EAGLContext *_contextEAGL;
    CIContext   *_contextCI;
    MSVCanvasModel *_canvasModel;
    
    MSVToolsInventoryView *_toolView;
    MSVToolsInventoryController *_toolViewController;
    MSVZoomController *_zoomController;
    MSVShadowController *_shadowController;
    UIPopoverController *_popoverController;
    
    CIImage *_checkerBoardImage;
}

- (void)setupGL;
- (void)tearDownGL;

@end

@implementation MSVViewController

-(instancetype) init
{
    self = [super self];
    
    if(self)
    {
        _contextEAGL = nil;
        _contextCI  = nil;
        _canvasModel = nil;
        
        _toolView = nil;
        _toolViewController = nil;
        _checkerBoardImage = nil;
        _popoverController = nil;
        _shadowController = nil;
        _zoomController = nil;
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
    
    _contextEAGL = nil;
    _contextCI  = nil;
    _canvasModel = nil;
    
    _toolView = nil;
    _toolViewController = nil;
    _checkerBoardImage = nil;
    _popoverController = nil;
    _shadowController = nil;
    _zoomController = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    [self setupGL];
    [self setupToolBar];
    [self setupSubViews];
    [self setupCheckerBoardImage];
    
    [MSVScreen initWithScreenBounds:self.view.bounds];
    
    [MSVGraphics init];
    [MSVGraphics loadDefaultMatrixes];
    
    _canvasModel = [MSVCanvasModel create];
}

-(void) setupSubViews
{
    _toolView = [MSVToolsInventoryView createWithFrame:CGRectMake(20.f, 50.f, 60.f, 400.f)];
    _toolViewController = [MSVToolsInventoryController createWithView:_toolView];
    [self.view addSubview:_toolView];
    
    [[MSVToolInventory sharedInstance] fillToolButtonsInView:_toolView];
}

-(void) setupCheckerBoardImage
{
    CIFilter *checkerBoardFilter = [CIFilter filterWithName:@"CICheckerboardGenerator"];
    
    [checkerBoardFilter setDefaults];
    [checkerBoardFilter setValue:[NSNumber numberWithInt:10] forKey:@"inputWidth"];
    [checkerBoardFilter setValue:[CIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.f] forKey:@"inputColor0"];
    [checkerBoardFilter setValue:[CIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f]  forKey:@"inputColor1"];
    
    _checkerBoardImage = [checkerBoardFilter valueForKey:@"outputImage"];
}

-(void) setupToolBar
{
    //<tool bar
    UIBarButtonItem *photoAlbumItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Photo Album", @"Photo Album")
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(openPhotoAlbum:)];
    
    
    UIBarButtonItem *shadowFilterItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Shadow Filter", @"Shadow Filter")
                                                                         style:UIBarButtonItemStyleDone
                                                                        target:self
                                                                        action:@selector(openShadowFilter:)];
    
    UIBarButtonItem *zoomItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Zoom", @"Zoom")
                                                                         style:UIBarButtonItemStyleDone
                                                                        target:self
                                                                        action:@selector(openZoomWindow:)];
    
    
    NSArray *toolbarItems = [NSArray arrayWithObjects: photoAlbumItem, shadowFilterItem, zoomItem, nil];
    
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
    [EAGLContext setCurrentContext:_contextEAGL];
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:_contextEAGL];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    
    [_canvasModel touchesBeganInPos:pos];
    
    /*
    {
        CGFloat s = 1.5f;
        CGAffineTransform tr = CGAffineTransformScale(_toolView.transform, s, s);
        CGFloat h = _toolView.frame.size.height;
        CGFloat w = _toolView.frame.size.width;
        
        _toolView.transform = tr;
        
        [UIView animateWithDuration:2.5 delay:0 options:0 animations:^{
            _toolView.transform = tr;
            _toolView.center = CGPointMake(w-w*s/2,h*s/2);
        
        } completion:^(BOOL finished) {}];

    }
    */

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    
    [_canvasModel touchesMovedInPos:pos];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    
    [_canvasModel touchesEndedInPos:pos];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    
    [_canvasModel touchesCancelledInPos:pos];
}

#pragma mark tool bar items
-(void) openPhotoAlbum:(id)sender
{
    UIImagePickerController *pickerC = [[UIImagePickerController alloc] init];
    
    pickerC.delegate = self;
    [self presentViewController:pickerC animated:YES completion:nil];
}

-(void) openShadowFilter:(id)sender
{
    _shadowController = [[MSVShadowController alloc] initWithNibName:@"MSVShadow" bundle:nil];
    
    _popoverController = [[UIPopoverController alloc] initWithContentViewController:_shadowController];
    [_popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}


-(void) openZoomWindow:(id)sender
{
    _zoomController = [MSVZoomController createWithNibName:@"MSVZoom" bundle:nil andRootController:self];
    
    _popoverController = [[UIPopoverController alloc] initWithContentViewController:_zoomController];
    [_popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *uiImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    CIImage *ciImage = [CIImage imageWithCGImage:uiImage.CGImage];
    
    const CGRect extentRect = [ciImage extent];
    
    //<synchronize with camera
    const CGPoint imageElementPos = [MSVScreen centerPoint];
    const CGSize imageElementSize = extentRect.size;
    
    MSVCanvasImageElement *imageElement = [MSVCanvasImageElement createWithCIImage:ciImage atPos:imageElementPos withSize:imageElementSize];
    [_canvasModel addElelemet:imageElement];
    
    //<some unknown hack it will pause controller :(
    self.paused = NO;
}

- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) scaleToolView:(float) scale
{
    //<I am sorry :(
    CGFloat s = 1.05f;
    CGAffineTransform tr = CGAffineTransformScale(_toolView.transform, s, s);
    CGFloat h = _toolView.frame.size.height;
    CGFloat w = _toolView.frame.size.width;
    
    _toolView.transform = tr;
    
    [UIView animateWithDuration:2.5 delay:0 options:0 animations:^{
        _toolView.transform = tr;
        _toolView.center = CGPointMake(w-w*s/2,h*s/2);
        
    } completion:^(BOOL finished) {}];
}


#pragma mark - GLKView and GLKViewController delegate methods
- (void)update
{
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self drawCheckerBoard];
    [_canvasModel drawWithCIContext:_contextCI];
}

-(void) drawCheckerBoard
{
    //CILanczosScaleTransform for scaling
    //<https://developer.apple.com/library/ios/documentation/graphicsimaging/Conceptual/CoreImaging/ci_custom_filters/ci_custom_filters.html
    //https://gist.github.com/jad/105640
    //<http://en.wikipedia.org/wiki/Quartz_Composer
    
    
    //<render
    CGPoint ciImagePos = CGPointZero;
    CGSize ciImageSize = CGSizeMake([MSVScreen width], [MSVScreen height]);
    
    ciImagePos  = [MSVScreen scaledPoint:ciImagePos];
    ciImageSize = [MSVScreen scaledSize:ciImageSize];
    
    CGRect inRect = CGRectMake(ciImagePos.x, ciImagePos.y, ciImageSize.width, ciImageSize.height);
    [_contextCI drawImage:_checkerBoardImage inRect:inRect fromRect:inRect];
}

@end
