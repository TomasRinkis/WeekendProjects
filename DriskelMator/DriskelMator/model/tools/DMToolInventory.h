//
//  DMToolInventory.h
//  DriskelMator
//
//  Created by Brolis on 5/1/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMToolInventory : NSObject

@property(nonatomic, strong, readonly) NSArray *toolArray;

-(void) fillView:(UIView*)view;
-(void) unselectAllTools;

+(instancetype) sharedInstance;

@end
