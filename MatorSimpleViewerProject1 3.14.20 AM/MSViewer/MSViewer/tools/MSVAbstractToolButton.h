//
//  MSVAbstractTool.h
//  MSViewer
//
//  Created by Brolis on 7/11/14.
//  Copyright (c) 2014 MSV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSVAbstractToolButton : UIButton

@property(nonatomic, readonly, strong) UIImage *icon;
@property(nonatomic, readonly, strong) NSString *iconName;

-(instancetype) initWithBounds:(CGRect)bounds;

-(void) useButtonReleasedBackground;
-(void) useButtonPressedBackground;

-(void) pressButton;
-(void) releaseButton;

+(int) dimension;
+(int) halfDimension;


@end
