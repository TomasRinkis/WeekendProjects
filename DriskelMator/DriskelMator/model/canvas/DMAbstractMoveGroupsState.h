//
//  DMAbstractMoveState.h
//  DriskelMator
//
//  Created by Brolis on 5/3/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "DMAbstarctState.h"
#import <GLKit/GLKVector2.h>

typedef enum
{
    DirectionNoneFlag,
    DirectionLeftFlag,
    DirctionRightFlag,
    DirectionUpFlag,
    DirectionDownFlag
} MoveDirectionEnum;


@interface DMAbstractMoveGroupsState : DMAbstarctState

@property(nonatomic) MoveDirectionEnum moveDirectionState;
@property(nonatomic, strong) NSMutableArray* selectedElements;

-(id) initWithCanvas:(DMCanvas*) canvas;

-(void) moveElementsLeft:(NSMutableArray*)elements by:(GLKVector2) pos;
-(void) moveElementsRight:(NSMutableArray*)elements by:(GLKVector2) pos;
-(void) moveElementsUp:(NSMutableArray*)elements by:(GLKVector2) pos;
-(void) moveElementsDown:(NSMutableArray*)elements by:(GLKVector2) pos;

-(NSMutableArray*) getLeftSideElementsFromPos:(GLKVector2) pos;
-(NSMutableArray*) getRightSideElementsFromPos:(GLKVector2) pos;

-(NSMutableArray*) getTopSideElementsFromPos:(GLKVector2) pos;
-(NSMutableArray*) getBotSideElementsFromPos:(GLKVector2) pos;


@end
