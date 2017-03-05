//
//  UINavigationController+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**A UINavagationController category that adds a progress view to the UINavigationBar.*/
@interface UINavigationController (PKAdd)

/**Show the progress bar.*/
- (void)showProgress;
/**Set the progress to display on the progress bar.
 @param progress The progress to display as a percentage from 0-1.
 @param animated Wether or not to animate the change.*/
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
/**Set the string to replace the UINavigationBar's title with while showing progress. Send nil to reset the title.
 @param title The string to replace the UINavigationBar's title while showing progress.*/
- (void)setProgressTitle:(NSString *)title;
/**Set whether or not to show indeterminate.
 @param indeterminate wether or not the progress bar is indeterminate.*/
- (void)setIndeterminate:(BOOL)indeterminate;
/**Get whether or not to show indeterminate.*/
- (BOOL)getIndeterminate;
/**Fill the progress bar completely and remove it from display.*/
- (void)finishProgress;
/**Remove the progress bar from the display.*/
- (void)cancelProgress;
/**Wether or not the progress bar is showing.*/
- (BOOL)isShowingProgressBar;
/**
 The primary color of the progress bar if you do not want it to be the same as the UINavigationBar's tint color. If set to nil, the UINavigationBar's tint color will be used.
 
 @param primaryColor The color to set.
 */
- (void)setPrimaryColor:(UIColor *)primaryColor;
/**
 The secondary color of the progress bar, if nil, the secondary color will be the barTintColor.
 
 @param secondaryColor The color to set.
 */
- (void)setSecondaryColor:(UIColor *)secondaryColor;

@end
