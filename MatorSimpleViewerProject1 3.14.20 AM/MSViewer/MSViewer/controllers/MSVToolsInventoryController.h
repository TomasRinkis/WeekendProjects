//
//  MSVToolsInventoryController.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MSVToolsInventoryView;

@interface MSVToolsInventoryController : UIViewController

@property (nonatomic, weak, readonly) MSVToolsInventoryView *toolInventoryView;

+(instancetype) createWithView:(MSVToolsInventoryView*) view;

@end
