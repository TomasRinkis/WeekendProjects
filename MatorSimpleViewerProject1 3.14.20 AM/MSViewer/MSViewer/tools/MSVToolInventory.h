//
//  MSVToolInventory.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, MSVToolType)
{
    MSVToolTypeSelect  = 0,
    MSVToolTypeCrop    = 1,
    MSVToolTypeDelete  = 2,
    MSVToolTypeZoom    = 3,
};


@interface MSVToolInventory : NSObject

@property(nonatomic, strong, readonly) NSArray *toolArray;

-(void) fillToolButtonsInView:(UIView*)view;
-(void) unselectAllTools;

-(void) pressButtonWithType:(MSVToolType) type;

@end


@interface MSVToolInventory(MSVToolInventoryCreation)

+(instancetype) sharedInstance;

@end