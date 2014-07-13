//
//  MSVToolInventory.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSVToolInventory : NSObject

@property(nonatomic, strong, readonly) NSArray *toolArray;

-(void) fillToolButtonsInView:(UIView*)view;
-(void) unselectAllTools;

+(instancetype) sharedInstance;

@end
