//
//  DMSingletonProtocol.h
//  DriskelMator
//
//  Created by Brolis on 5/18/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DMSingletonProtocol <NSObject>

+(instancetype) sharedInstance;

-(void) create;
-(void) destroy;

@end
