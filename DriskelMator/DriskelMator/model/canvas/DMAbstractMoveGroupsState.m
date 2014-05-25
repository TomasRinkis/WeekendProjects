//
//  DMAbstractMoveState.m
//  DriskelMator
//
//  Created by Brolis on 5/3/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMAbstractMoveGroupsState.h"
#import "DMCanvas.h"
#import "DMAbtractElement.h"

@implementation DMAbstractMoveGroupsState

@synthesize moveDirectionState = _moveDirectionState;
@synthesize selectedElements   = _selectedElements;


-(id) initWithCanvas:(DMCanvas*) canvas
{
    self = [super initWithCanvas:canvas];
    
    if(self)
    {
        _moveDirectionState = DirectionNoneFlag;
        _selectedElements = NULL;
    }
    
    return self;
}

-(void) moveElementsLeft:(NSMutableArray*)elements by:(GLKVector2) pos
{
    
}

-(void) moveElementsRight:(NSMutableArray*)elements by:(GLKVector2) pos
{
    
}

-(void) moveElementsUp:(NSMutableArray*)elements by:(GLKVector2) pos
{
    
}

-(void) moveElementsDown:(NSMutableArray*)elements by:(GLKVector2) pos
{
    
}


-(NSMutableArray*) getLeftSideElementsFromPos:(GLKVector2) pos
{
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (DMAbtractElement *element  in [[self canvas] elementArray])
    {
        if(element.position.x < pos.x)
        {
            [elements addObject:element];
        }
        
    }
    
    return elements;
}

-(NSMutableArray*) getRightSideElementsFromPos:(GLKVector2) pos
{
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (DMAbtractElement *element  in [[self canvas] elementArray])
    {
        if(element.position.x > pos.x)
        {
            [elements addObject:element];
        }
        
    }
    
    return elements;
}


-(NSMutableArray*) getTopSideElementsFromPos:(GLKVector2) pos
{
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (DMAbtractElement *element  in [[self canvas] elementArray])
    {
        if(element.position.y > pos.y)
        {
            [elements addObject:element];
        }
        
    }
    
    return elements;
}

-(NSMutableArray*) getBotSideElementsFromPos:(GLKVector2) pos
{
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (DMAbtractElement *element  in [[self canvas] elementArray])
    {
        if(element.position.y < pos.y)
        {
            [elements addObject:element];
        }
        
    }
    
    return elements;
}


@end
