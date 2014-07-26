//
//  MSVCanvasModel.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVCanvasModel.h"
#import "MSVCanvasImageElement.h"
#import "MSVCanvasAbstractState.h"
#import "MSVCanvasSelectState.h"
#import "MSVCanvasCropState.h"
#import "MSVCanvasDeleteState.h"
#import "MSVCanvasZoomState.h"
#import "MSVGraphics.h"
#import "MSVShaderContainer.h"
#import "MSVShaderProgram.h"
#import "MSVShaderConstants.h"
#import "MSVNotifications.h"
#import "MSVToolInventory.h"
#import "MSVCrop.h"
#import "MSVScreen.h"

@interface MSVCanvasModel()
{
    MSVCanvasAbstractState *currentState;
    MSVCanvasSelectState *selectState;
    MSVCanvasCropState *cropState;
    MSVCanvasDeleteState *deleteState;
    MSVCanvasZoomState  *zoomState;
    
}
@end

@implementation MSVCanvasModel

@synthesize selectedElement = _selectedElement;
@synthesize elementArray =_elementArray;

-(instancetype) init
{
    self = [super init];
    
    if(self)
    {
        self.selectedElement = nil;
        self.elementArray = [[NSMutableArray alloc] init];
        
        selectState = [MSVCanvasSelectState createWithCanvasModel:self];
        cropState   = [MSVCanvasCropState createWithCanvasModel:self];
        deleteState = [MSVCanvasDeleteState createWithCanvasModel:self];
        
        currentState = selectState;
        [[MSVToolInventory sharedInstance] pressButtonWithType:MSVToolTypeSelect];
        
    
        //<init notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleSelectStateNotification:)
                                                     name:[MSVNotification CanvasSelectState]
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleCropStateNotification:)
                                                     name:[MSVNotification CanvasCropState]
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleDeleteStateNotification:)
                                                     name:[MSVNotification CanvasDeleteState]
                                                   object:nil];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleCanvasStateNotification:)
                                                     name:[MSVNotification CanvasZoomState]
                                                   object:nil];
    }
    
    return self;
}

-(void) dealloc
{
}

- (void)touchesBeganInPos:(CGPoint) pos
{
    if(currentState)
    {
        [currentState touchesBeganInPos:pos];
    }
}

- (void)touchesMovedInPos:(CGPoint) pos
{
    if(currentState)
    {
        [currentState touchesMovedInPos:pos];
    }
}

- (void)touchesEndedInPos:(CGPoint) pos
{
    if(currentState)
    {
        [currentState touchesEndedInPos:pos];
    }
}

- (void)touchesCancelledInPos:(CGPoint) pos
{
    if(currentState)
    {
        [currentState touchesCancelledInPos:pos];
    }
}

-(void) tryPerformCropOnSelectedElement
{
    if(self.selectedElement)
    {
        CIImage *selectedImage = self.selectedElement.image;
        CGSize cropSize = self.selectedElement.crop.size; //delete scale factor
        const float scale = [MSVScreen scale];
 
        cropSize.height /= scale;
        cropSize.width  /= scale;
        
        CGRect cropRect = CGRectMake(0.f, 0.f, cropSize.width, cropSize.height);
        CIImage *croppedImage = [selectedImage imageByCroppingToRect:cropRect];
        
        
        MSVCanvasImageElement *imageElement = [MSVCanvasImageElement createWithCIImage:croppedImage atPos:CGPointMake(300.f, 200.f) withSize:cropSize];
        [self addElelemet:imageElement];
    }
}

-(void) addElelemet:(MSVCanvasAbstractElement*) element
{
    [self.elementArray addObject:element];
}

-(void) deleteElement:(MSVCanvasAbstractElement*) element
{
    self.selectedElement = nil;

    [self.elementArray removeObject:element];
}

-(void) unselectAllElements
{
    self.selectedElement = nil;
    
    for(MSVCanvasAbstractElement *element in self.elementArray)
    {
        element.selected = FALSE;
    }
}

-(void) drawWithCIContext:(CIContext *)contextCI
{
    for(MSVCanvasAbstractElement *element in self.elementArray)
    {
        [element drawWithCIContext:contextCI];
    }
    
    [self drawSelection];
}

-(void) drawSelection
{
    MSVShaderProgram *primitiveShader = [[MSVShaderContainer sharedInstance] getShaderProgramFromName:[MSVShaderConstants primitiveShaderName]];
    [MSVGraphics setShaderProgram:primitiveShader];
    
    if(currentState)
    {
        [currentState drawSelection];
    }
}

-(void) handleSelectStateNotification:(NSNotification *)aNotification
{
    currentState = selectState;
}

-(void) handleCropStateNotification:(NSNotification *)aNotification
{
    currentState = cropState;
}

-(void) handleDeleteStateNotification:(NSNotification *)aNotification
{
    currentState = deleteState;
}

-(void) handleCanvasStateNotification:(NSNotification *)aNotification
{
    currentState = zoomState;
}

-(void) setFloatValue:(float) value forProperty:(NSString*) property
{
    if(self.selectedElement)
    {
        [self.selectedElement setFloatValue:value forProperty:property];
    }
}

-(void) setBoolValue:(bool) value forProperty:(NSString*) property
{
    if(self.selectedElement)
    {
        [self.selectedElement setBoolValue:value forProperty:property];
    }
}


-(void) setIntValue:(int) value forProperty:(NSString *) property
{
    if(self.selectedElement)
    {
        [self.selectedElement setIntValue:value forProperty:property];
    }
}

+(instancetype) create
{
    return [[MSVCanvasModel alloc] init];
}

@end
