//
//  UIApplication+PKAdd.m
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "UIApplication+PKAdd.h"

@implementation UIApplication (PKAdd)

- (UIViewController *)topmostViewController
{
    return [self _topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)_topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self _topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        return [self _topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController) {
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self _topViewControllerWithRootViewController:presentedViewController];
    }
    else {
        return rootViewController;
    }
}

@end
