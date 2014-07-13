//
//  MSVToolsInventoryController.m
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import "MSVToolsInventoryController.h"
#import "MSVToolsInventoryView.h"

@implementation MSVToolsInventoryController

@synthesize toolInventoryView = _toolInventoryView;

- (id)initWithView:(MSVToolsInventoryView*) view;
{
    self = [super init];
    
    if (self)
    {
        _toolInventoryView = view;
        self.view = _toolInventoryView;
    }
    return self;
}

+(instancetype) createWithView:(MSVToolsInventoryView*) view
{
    return [[MSVToolsInventoryController alloc] initWithView:view];
}

@end
