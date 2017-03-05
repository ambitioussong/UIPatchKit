//
//  UIColor+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PKAdd)

+ (UIColor *)colorWithHex:(uint)hex;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

- (NSString *)hexString;

+ (UIColor *)colorBetweenSrc:(UIColor *)srcColor des:(UIColor *)desColor percent:(CGFloat)percent;

@end
