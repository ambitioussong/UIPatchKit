//
//  UICollectionViewFlowLayout+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define INDICATOR_MAX_WIDTH         ([[UIScreen mainScreen] bounds].size.width * 0.2)

@interface UICollectionViewFlowLayout (PKAdd)

- (CGFloat)sectionPercentOfIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)sectionPercentOfContentOffset:(CGFloat)offset;
- (NSInteger)currentSectionContentOffset:(CGFloat)offset;
- (NSIndexPath *)firstIndexPathOfContentOffset:(CGFloat)contentOffset;

@end
