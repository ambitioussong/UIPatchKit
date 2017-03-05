//
//  UIBlurEffect+PKAdd.m
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "UIBlurEffect+PKAdd.h"
#import <objc/runtime.h>

@implementation CustomBlurEffect

static CGFloat blurRadius = 5.0f;

+ (instancetype)effectWithStyle:(UIBlurEffectStyle)style
{
    id result = [super effectWithStyle:style];
    object_setClass(result, self);
    
    return result;
}

- (id)effectSettings
{
    id settings = [super effectSettings];
    [settings setValue:@(blurRadius) forKey:@"blurRadius"];
    return settings;
}

- (id)copyWithZone:(NSZone*)zone
{
    id result = [super copyWithZone:zone];
    object_setClass(result, [self class]);
    return result;
}

- (void)pins_setBlurRadius:(CGFloat)radius;
{
    blurRadius = radius;
}

@end
