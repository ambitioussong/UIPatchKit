//
//  UICollectionViewCell+PKAdd.m
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "UICollectionViewCell+PKAdd.h"
#import <objc/runtime.h>

static void *kDeleteActionKey;
static NSString * kShakeAnimationKey = @"kShakeAnimationKey";
static NSUInteger kCloseButtonTag = 11;

@implementation UICollectionViewCell (PKAdd)

#pragma mark - action methods

- (void)onCloseButton {
    
    DeleteAction action = objc_getAssociatedObject(self, &kDeleteActionKey);
    if (action) {
        action();
    }
}


#pragma mark - private methods

- (CABasicAnimation *)shakeAnimation {
    
    CABasicAnimation *  shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [shakeAnimation setToValue:[NSNumber numberWithFloat:-M_PI/72]];
    [shakeAnimation setFromValue:[NSNumber numberWithDouble:M_PI/72]];
    [shakeAnimation setDuration:0.20];
    [shakeAnimation setRepeatCount:HUGE_VAL];
    [shakeAnimation setAutoreverses:YES];
    return shakeAnimation;
}

- (void)addCloseButton {
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.backgroundColor = [UIColor clearColor];
    closeBtn.tag = kCloseButtonTag;
    [closeBtn addTarget:self action:@selector(onCloseButton) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIImageView *closeIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomizeDeleteSingle"]];
    closeIcon.translatesAutoresizingMaskIntoConstraints = NO;
    
    [closeBtn addSubview:closeIcon];
    [self.contentView addSubview:closeBtn];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(closeBtn, closeIcon);
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[closeBtn]|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[closeBtn]|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[closeIcon(22)]|" options:0 metrics:nil views:views]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[closeIcon(22)]" options:0 metrics:nil views:views]];
    
    [self.contentView bringSubviewToFront:closeBtn];
}

- (void)removeCloseButton {
    
    UIView *closeButton = [self.contentView viewWithTag:kCloseButtonTag];
    if (closeButton) {
        [closeButton removeFromSuperview];
    }
}


#pragma mark - public methods

- (void)enterDeleteState {
    
    [self.layer addAnimation:[self shakeAnimation] forKey:kShakeAnimationKey];
    [self addCloseButton];
}

- (void)leaveDeleteState {
    
    [self.layer removeAnimationForKey:kShakeAnimationKey];
    [self removeCloseButton];
}

- (void)setDeleteAction:(void(^)(void))block {
    
    objc_setAssociatedObject(self, &kDeleteActionKey, block, OBJC_ASSOCIATION_COPY);
}

@end
