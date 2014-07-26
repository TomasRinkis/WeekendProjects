//
//  MSVCanvasController.m
//  MSViewer
//
//  Created by Brolis on 7/23/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasController.h"
#import "MSVCanvasModel.h"

@interface MSVCanvasController ()
{
    UIPopoverController *_popoverController;
    
    EAGLContext *_contextEAGL;
    CIContext   *_contextCI;
    CIImage     *_checkerBoardImage;
}

@end

@implementation MSVCanvasController

@synthesize canvasModel = _canvasModel;

-(instancetype) initWithGLKView:(GLKView*) glView
{
    self = [super init];
    
    if(self)
    {
        self.view = glView;
        [self setupState];
    }
    
    return self;
}

-(void) setupState
{
    {//<context
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
        [EAGLContext setCurrentContext:_contextEAGL];
    }
    
    {//<state variables
        _canvasModel = [MSVCanvasModel create];
    }
    
    {//<check board
        CIFilter *checkerBoardFilter = [CIFilter filterWithName:@"CICheckerboardGenerator"];
        
        [checkerBoardFilter setDefaults];
        [checkerBoardFilter setValue:[NSNumber numberWithInt:10] forKey:@"inputWidth"];
        [checkerBoardFilter setValue:[CIColor colorWithRed:0.8f green:0.8f blue:0.8f alpha:1.f] forKey:@"inputColor0"];
        [checkerBoardFilter setValue:[CIColor colorWithRed:1.f green:1.f blue:1.f alpha:1.f]  forKey:@"inputColor1"];
        
        _checkerBoardImage = [checkerBoardFilter valueForKey:@"outputImage"];
    }
}

- (void)dealloc
{
    [self clearState];
}

-(void) clearState
{
    [EAGLContext setCurrentContext:nil];
    
    _contextEAGL = nil;
    _contextCI  = nil;
    _checkerBoardImage = nil;
    _popoverController = nil;
    _canvasModel = nil;
}

+(instancetype) createWithGLKView:(GLKView*) glView
{
    return [[MSVCanvasController alloc] initWithGLKView:glView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil))
    {
        self.view = nil;
        
        if ([EAGLContext currentContext] == _contextEAGL)
        {
            [EAGLContext setCurrentContext:nil];
        }
        _contextEAGL = nil;
        _contextCI = nil;
    }
    
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch     = (UITouch*)[touches anyObject];
    CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
    [_canvasModel touchesBeganInPos:pos];
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

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self drawCheckerBoard];
    [_canvasModel drawWithCIContext:_contextCI];
}

-(void) drawCheckerBoard
{
    //<render
    CGPoint ciImagePos = CGPointZero;
    CGSize ciImageSize = self.view.bounds.size;
    
    CGRect inRect = CGRectMake(ciImagePos.x, ciImagePos.y, ciImageSize.width, ciImageSize.height);
    [_contextCI drawImage:_checkerBoardImage inRect:inRect fromRect:inRect];
}

@end
