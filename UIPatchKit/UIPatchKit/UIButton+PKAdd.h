//
//  UIButton+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^UIEventBlock)(id sender, UIEvent *event);

@interface UIButton (PKAdd)

@property (nonatomic, copy) UIEventBlock onTouchUpInside;

-(void)setImageTintColor:(UIColor *)color forState:(UIControlState)state;
-(void)setBackgroundTintColor:(UIColor *)color forState:(UIControlState)state;

+(void)tintButtonImages:(NSArray *)buttons withColor:(UIColor *)color forState:(UIControlState)state;
+(void)tintButtonBackgrounds:(NSArray *)buttons withColor:(UIColor *)color forState:(UIControlState)state;

@end
