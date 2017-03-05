//
//  UIColor+PKAdd.m
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "UIColor+PKAdd.h"

@implementation UIColor (PKAdd)

+ (UIColor *)colorWithHex:(uint)hex {
    int red, green, blue, alpha;
    
    blue = hex & 0x000000FF;
    green = ((hex & 0x0000FF00) >> 8);
    red = ((hex & 0x00FF0000) >> 16);
    alpha = ((hex & 0xFF000000) >> 24);
    
    return [UIColor colorWithRed:red/255.0f
                           green:green/255.0f
                            blue:blue/255.0f
                           alpha:alpha/255.f];
}

+ (UIColor *)colorWithHexString:(NSString *)hexString {
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#" withString: @""] uppercaseString];
    CGFloat alpha, red, blue, green;
    switch ([colorString length]) {
        case 3: // #RGB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            break;
        case 4: // #ARGB
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            break;
        case 6: // #RRGGBB
            alpha = 1.0f;
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            break;
        case 8: // #AARRGGBB
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            break;
        default:
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            break;
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

- (NSString *)hexString {
    
    CGFloat r , g , b , al;
    [self getRed:&r green:&g blue:&b alpha:&al];
    
    unsigned int red, green , blue,alpha;
    red = r*255;
    green = g*255;
    blue = b*255;
    alpha = al*255;
    
    NSString *res = [NSString stringWithFormat:@"#%02X%02X%02X%02X",alpha,red,green,blue];
    return res;
}

+ (CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}

+ (UIColor *)colorBetweenSrc:(UIColor *)srcColor des:(UIColor *)desColor percent:(CGFloat)percent
{
    UIColor *color;
    if (percent < 0) {
        percent = 0;
    }
    else if (percent > 1) {
        percent = 1;
    }
    
    CGFloat srcR, srcG, srcB, srcA;
    CGFloat desR, desG, desB, desA;
    
    [srcColor getRed:&srcR green:&srcG blue:&srcB alpha:&srcA];
    [desColor getRed:&desR green:&desG blue:&desB alpha:&desA];
    
    CGFloat colorR, colorG, colorB, colorA;
    colorR = [self _interpolateBetweenA:srcR andB:desR percent:percent];
    colorG = [self _interpolateBetweenA:srcG andB:desG percent:percent];
    colorB = [self _interpolateBetweenA:srcB andB:desB percent:percent];
    colorA = [self _interpolateBetweenA:srcA andB:desA percent:percent];
    
    color = [UIColor colorWithRed:colorR green:colorG blue:colorB alpha:colorA];
    return color;
}

+ (CGFloat)_interpolateBetweenA:(CGFloat)a andB:(CGFloat)b percent:(CGFloat)percent
{
    CGFloat interpolateValue;
    interpolateValue = a + (b - a) * percent;
    return interpolateValue;
}



@end
