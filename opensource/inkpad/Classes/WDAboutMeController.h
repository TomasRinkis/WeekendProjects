//
//  WDAboutMenController.h
//  Inkpad
//
//  Created by Brolis on 6/14/14.
//  Copyright (c) 2014 Taptrix, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

//<Copied-reviewd from help
@interface WDAboutMeController : UIViewController <UIPrintInteractionControllerDelegate>
+(instancetype) createWithNibName:(NSString*)nibNameOrNil andBundle:(NSBundle*)nibBundleOrNil;
@end
