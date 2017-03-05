//
//  UIViewController+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (PKAdd)

/**
 *  The hideView will auto hide with scrollview scroll up and auto expand with scorllView scrol down.
 *
 *  @param originY   The hideView expaned state's frame.origin.Y
 */
- (void)setNeedAutoHideView:(nonnull UIView *)hideView scrollView:(nonnull UIScrollView *)scrollView originY:(CGFloat)originY;

/**
 *  Observe the scollview related scrollUp and scrollDown events.
 *  Attention: This method and method setNeedAutoHideView:scrollView:originY: can't be used at the same time with two different scrollView.
 Because there is only one property in .m file to hold the scrollView.
 *
 *  @param scrollView        The scollView being observed.
 *  @param scrollUpCallback   When scrollView scrollUp event occurs, the srollUpCallback will be called.
 *  @param scrollDownCallback When scrollView scrollUp event occurs, the srollUpCallback will be called.
 */
- (void)observeScrollView:(nonnull UIScrollView *)scrollView didScrollUp:(nullable void(^)(void))scrollUpCallback disScrollDown:(nullable void(^)(void))scrollDownCallback;

@end
