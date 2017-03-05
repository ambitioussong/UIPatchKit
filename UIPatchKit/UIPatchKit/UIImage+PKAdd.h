//
//  UIImage+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^renderToContext)(CGContextRef, CGRect);

@interface UIImage (PKAdd)

+ (UIImage *)imageWithSize:(CGSize)size renderer:(renderToContext)renderer;
+ (UIImage *)imageWithSize:(CGSize)size opaque:(BOOL)opaque renderer:(renderToContext)renderer;
+ (UIImage *)zoomScreenshotImageWithSize:(CGSize)size;
- (UIImage *)resizedImageToSize:(CGSize)dstSize;
- (UIImage *)resizedImageToFitInSize:(CGSize)boundingSize scaleIfSmaller:(BOOL)scale;

- (UIImage *)imageWithScreenScale;
- (UIImage *)imageWithAspect:(CGSize)aspect;
- (CGSize)imageSizeWithAspect:(CGSize)aspect;

- (UIImage *)imageCroppedToRect:(CGRect)rect;
- (UIImage *)imageScaledToSize:(CGSize)size;
- (UIImage *)imageScaledToFitSize:(CGSize)size;
- (UIImage *)imageScaledToFillSize:(CGSize)size;
- (UIImage *)imageCroppedAndScaledToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode padToFit:(BOOL)padToFit;
- (UIImage *)reflectedImageWithScale:(CGFloat)scale;
- (UIImage *)imageWithReflectionWithScale:(CGFloat)scale gap:(CGFloat)gap alpha:(CGFloat)alpha;
- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
- (UIImage *)imageWithAlpha:(CGFloat)alpha;
- (UIImage *)imageWithMask:(UIImage *)maskImage;
- (UIImage *)maskImageFromImageAlpha;
- (UIImage *)imageWithStroke:(UIColor *)color withWidth:(CGFloat)width withCornerRadius:(CGFloat)radius;

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

- (UIImage *)croppedImageWithSize:(CGSize)size;
- (UIImage *)tintImageWithColor:(UIColor *)tintColor;
- (UIImage *)blurredImage;
- (UIImage *)blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations tintColor:(UIColor *)tintColor;


@end
