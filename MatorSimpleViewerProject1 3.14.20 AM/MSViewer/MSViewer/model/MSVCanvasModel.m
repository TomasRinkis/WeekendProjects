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

#import "MSVNotifications.h"

@interface MSVCanvasModel()
{
    MSVCanvasAbstractState *currentState;
    MSVCanvasSelectState *selectState;
    MSVCanvasCropState *cropState;
    MSVCanvasDeleteState *deleteState;
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


+(instancetype) create
{
    return [[MSVCanvasModel alloc] init];
}

@end
