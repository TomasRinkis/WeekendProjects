//
//  DMPath.m
//  DriskelMator
//
//  Created by Brolis on 4/13/14.
//  Copyright (c) 2014 DM. All rights reserved.
//

#import "MSVPath.h"

@implementation MSVPath

+(NSString*) pathInBundleForResource:(NSString*)resource ofType:(NSString*) type
{
   return [[NSBundle mainBundle] pathForResource:resource ofType:type];
}

@end
