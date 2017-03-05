//
//  UIView+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString * const CSToastPositionTop;
extern NSString * const CSToastPositionCenter;
extern NSString * const CSToastPositionBottom;

@interface UIView (PKAdd)

- (void)touchScaleAnimationWithCompletion:(void (^)(BOOL finished))completion;

// each makeToast method creates a view and displays it as toast
- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title image:(UIImage *)image;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position backgroundImage:(UIImage *)backgroundImage foregroundLeftImage:(UIImage *)leftImage foregroundRightImage:(UIImage *)rightImage;

// displays toast with an activity spinner
- (void)makeToastActivity;
- (void)makeToastActivity:(id)position;
- (void)hideToastActivity;

// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)point;

@end
