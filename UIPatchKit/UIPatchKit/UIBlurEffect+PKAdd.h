//
//  UIBlurEffect+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBlurEffect (PKAdd)
@property (nonatomic, readonly) id effectSettings;
@end

@interface CustomBlurEffect : UIBlurEffect

/**
 *  Set the blur radius
 *
 *  @param radius default is 5.0f
 */
- (void)pins_setBlurRadius:(CGFloat)radius;

@end
