//
//  UIButton+PKAdd.m
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "UIButton+PKAdd.h"
#import <objc/runtime.h>

@interface UIButton (_PKAdd_)

- (void)button:(UIButton *)button touchUpInsideWithEvent:(UIEvent *)event;

@end

@implementation UIButton (PKAdd)

@dynamic onTouchUpInside;

static void *onTouchUpInsideKey = &onTouchUpInsideKey;

#pragma mark - EventBlocks

- (void)setOnTouchUpInside:(UIEventBlock)onTouchUpInside
{
    if(onTouchUpInside)
    {
        objc_setAssociatedObject(self, onTouchUpInsideKey, onTouchUpInside, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self addTarget:self action:@selector(button:touchUpInsideWithEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        objc_setAssociatedObject(self, onTouchUpInsideKey, nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self removeTarget:self action:@selector(button:touchUpInsideWithEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIEventBlock)onTouchUpInside
{
    return objc_getAssociatedObject(self, onTouchUpInsideKey);
}

- (void)button:(UIButton *)button touchUpInsideWithEvent:(UIEvent *)event
{
    self.onTouchUpInside(button, event);
}


#pragma mark - Image_Tint

-(void)setImageTintColor:(UIColor *)color forState:(UIControlState)state
{
    UIImage *image = [self imageForState:state];
    
    if(image)
        [self setImage:[self tintedImageWithColor:color image:image] forState:state];
    else
        NSLog(@"%@ UIButton does not have any image to tint.", self);
}

+(void)tintButtonImages:(NSArray *)buttons withColor:(UIColor *)color forState:(UIControlState)state
{
    for (UIButton *button in buttons)
    {
        [button setImageTintColor:color forState:state];
    }
}


#pragma mark - Background_Tint

-(void)setBackgroundTintColor:(UIColor *)color forState:(UIControlState)state
{
    if ([self backgroundImageForState:state])
        [self setBackgroundImage:[self tintedImageWithColor:color image:[self backgroundImageForState:state]] forState:state];
    else
        NSLog(@"%@ UIButton does not have any background image to tint.", self);
}

+(void)tintButtonBackgrounds:(NSArray *)buttons withColor:(UIColor *)color forState:(UIControlState)state
{
    for (UIButton *button in buttons)
    {
        [button setBackgroundTintColor:color forState:state];
    }
}


#pragma mark - Tint_Method

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor image:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // draw alpha-mask
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextDrawImage(context, rect, image.CGImage);
    
    // draw tint color, preserving alpha values of original image
    CGContextSetBlendMode(context, kCGBlendModeSourceIn);
    [tintColor setFill];
    CGContextFillRect(context, rect);
    
    UIImage *coloredImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return coloredImage;
}


@end
