//
//  UIViewController+PKAdd.m
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "UIViewController+PKAdd.h"
#import "NJKScrollFullScreen.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property (nonatomic, assign) BOOL autoHideViewExpanded;
@property (nonatomic, weak) UIView *hideView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) NJKScrollFullScreen *scrollProxy;

@property (nonatomic, strong) void(^scrollUpCallback)();
@property (nonatomic, strong) void(^scrollDownCallback)();

@property (nonatomic, assign) CGFloat originY; // The origin y of hideview.
@property (nonatomic, assign) UIEdgeInsets originInsets;

@end

@implementation UIViewController (PKAdd)

#pragma mark - Public

- (void)setNeedAutoHideView:(nonnull UIView *)hideView scrollView:(nonnull UIScrollView *)scrollView originY:(CGFloat)originY
{
    if (scrollView == self.scrollView && hideView == self.hideView) {
        [self configureViewState];
        return;
    }
    
    self.hideView     = hideView;
    self.scrollView   = scrollView;
    self.originY      = originY;
    self.originInsets = scrollView.contentInset;
    
    self.scrollProxy = [[NJKScrollFullScreen alloc] initWithForwardTarget:self];
    scrollView.delegate = (id)self.scrollProxy;
    self.scrollProxy.delegate = (id)self;
    
    [self configureViewState];
}

- (void)observeScrollView:(nonnull UIScrollView *)scrollView didScrollUp:(nullable void(^)(void))scrollUpCallback disScrollDown:(nullable void(^)(void))scrollDownCallback
{
    self.scrollUpCallback = scrollUpCallback;
    self.scrollDownCallback = scrollDownCallback;
    
    if (self.scrollView == scrollView) {
        return;
    }
    
    self.scrollView = scrollView;
    self.scrollProxy = [[NJKScrollFullScreen alloc] initWithForwardTarget:self];
    scrollView.delegate = (id)self.scrollProxy;
    self.scrollProxy.delegate = (id)self;
}


#pragma mark - Private

- (void)configureViewState
{
    self.autoHideViewExpanded = fabs(self.hideView.frame.origin.y - self.originY) < 1.0f;
    CGFloat offset = fabs(self.hideView.frame.origin.y - self.originY);
    
    UIEdgeInsets insets = self.originInsets;
    insets.top += self.hideView.frame.size.height - offset;
    [self.scrollView setContentInset:insets];
}

- (void)showHideView:(BOOL)animated
{
    [self setHideViewOriginY:self.originY animated:animated viewState:YES];
}

- (void)hideHideView:(BOOL)animated
{
    CGFloat y = self.originY - self.hideView.frame.size.height;
    [self setHideViewOriginY:y animated:animated viewState:NO];
}

- (void)moveHideView:(CGFloat)deltaY animated:(BOOL)animated
{
    CGFloat y = self.hideView.frame.origin.y + deltaY;
    [self setHideViewOriginY:y animated:animated viewState:self.autoHideViewExpanded];
}

- (void)setHideViewOriginY:(CGFloat)y animated:(BOOL)animated viewState:(BOOL)expanded
{
    if (expanded != self.autoHideViewExpanded) {
        if (expanded) {
            UIEdgeInsets insets = self.originInsets;
            insets.top += self.hideView.frame.size.height;
            [self.scrollView setContentInset:insets];
        }
        else {
            [self.scrollView setContentInset:self.originInsets];
        }
        self.autoHideViewExpanded = expanded;
    }
    
    CGFloat topLimit = self.originY - self.hideView.frame.size.height;
    CGFloat bottomLimit = self.originY;
    
    CGRect frame = self.hideView.frame;
    frame.origin.y = fmin(fmax(y, topLimit), bottomLimit);
    
    [UIView animateWithDuration:animated ? 0.1 : 0 animations:^{
        self.hideView.frame = frame;
    } completion:^(BOOL finished) {
        if (!finished && !CGRectEqualToRect(self.hideView.frame, frame)) {
            self.hideView.frame = frame;
        }
    }];
}


#pragma mark - NJKScrollFullScreenDelegate

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollUp:(CGFloat)deltaY
{
    [self moveHideView:deltaY animated:YES];
}

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollDown:(CGFloat)deltaY
{
    [self moveHideView:deltaY animated:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollUp:(NJKScrollFullScreen *)proxy
{
    [self hideHideView:YES];
    
    if (self.scrollUpCallback) {
        self.scrollUpCallback();
    }
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollDown:(NJKScrollFullScreen *)proxy
{
    [self showHideView:YES];
    
    if (self.scrollDownCallback) {
        self.scrollDownCallback();
    }
}


#pragma mark - Associated property

static char kHideViewKey;
- (UIView *)hideView {return objc_getAssociatedObject(self, &kHideViewKey);}
- (void)setHideView:(UIView *)hideView {objc_setAssociatedObject(self, &kHideViewKey, hideView, OBJC_ASSOCIATION_ASSIGN);}

static char kScrollViewKey;
- (UIScrollView *)scrollView {return objc_getAssociatedObject(self, &kScrollViewKey);}
- (void)setScrollView:(UIScrollView *)scrollView {objc_setAssociatedObject(self, &kScrollViewKey, scrollView, OBJC_ASSOCIATION_ASSIGN);}

static char kScrollProxyKey;
- (NJKScrollFullScreen *)scrollProxy {return objc_getAssociatedObject(self, &kScrollProxyKey);}
- (void)setScrollProxy:(NJKScrollFullScreen *)scrollProxy {objc_setAssociatedObject(self, &kScrollProxyKey, scrollProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);}

static char kOriginYKey;
- (CGFloat)originY {return [objc_getAssociatedObject(self, &kOriginYKey) floatValue];}
- (void)setOriginY:(CGFloat)originY {objc_setAssociatedObject(self, &kOriginYKey, @(originY), OBJC_ASSOCIATION_RETAIN);}

static char kOriginInsetsKey;
- (UIEdgeInsets)originInsets {return [objc_getAssociatedObject(self, &kOriginInsetsKey) UIEdgeInsetsValue];}
- (void)setOriginInsets:(UIEdgeInsets)originInsets {objc_setAssociatedObject(self, &kOriginInsetsKey, [NSValue valueWithUIEdgeInsets:originInsets], OBJC_ASSOCIATION_RETAIN);}

static char kAutoHideViewExpandedKey;
- (BOOL)autoHideViewExpanded {return [objc_getAssociatedObject(self, &kAutoHideViewExpandedKey) boolValue];}
- (void)setAutoHideViewExpanded:(BOOL)autoHideViewExpanded {objc_setAssociatedObject(self, &kAutoHideViewExpandedKey, @(autoHideViewExpanded), OBJC_ASSOCIATION_RETAIN);}

static char kScrollUpKey;
- (void (^)())scrollUpCallback {return objc_getAssociatedObject(self, &kScrollUpKey);}
- (void)setScrollUpCallback:(void (^)())scrollUpCallback {objc_setAssociatedObject(self, &kScrollUpKey, scrollUpCallback, OBJC_ASSOCIATION_RETAIN);}

static char kScrollDownKey;
- (void (^)())scrollDownCallback {return objc_getAssociatedObject(self, &kScrollDownKey);}
- (void)setScrollDownCallback:(void (^)())scrollDownCallback {objc_setAssociatedObject(self, &kScrollDownKey, scrollDownCallback, OBJC_ASSOCIATION_RETAIN);}


@end
