//
//  UICollectionViewFlowLayout+PKAdd.m
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import "UICollectionViewFlowLayout+PKAdd.h"

@implementation UICollectionViewFlowLayout (PKAdd)

- (CGRect)frameOfSection:(NSInteger)section {
    
    if (section < 0 || section >= [self.collectionView numberOfSections]) {
        return CGRectZero;
    }
    NSInteger count = [self.collectionView numberOfItemsInSection:section];
    
    if (count <= 0) {
        return CGRectMake(0,
                          self.collectionView.frame.origin.y,
                          self.sectionInset.left + self.sectionInset.right + self.minimumInteritemSpacing * 2,
                          self.sectionInset.top + self.sectionInset.bottom + self.minimumInteritemSpacing * 2);
    }
    
    UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:count - 1 inSection:section]];
    CGRect sectionFrame = CGRectUnion(firstItem.frame, lastItem.frame);
    sectionFrame.origin.x -= self.sectionInset.left + self.minimumInteritemSpacing;
    sectionFrame.size.width += self.sectionInset.left + self.sectionInset.right + self.minimumInteritemSpacing * 2;
    
    return sectionFrame;
}

- (NSIndexPath *)firstIndexPathOfContentOffset:(CGFloat)contentOffset {
    if (contentOffset == MAXFLOAT) {
        contentOffset = self.collectionView.contentOffset.x;
    }
    
    CGRect frame = self.collectionView.frame;
    frame.origin.x = contentOffset;
    NSArray *items = [self layoutAttributesForElementsInRect:frame];
    UICollectionViewLayoutAttributes *item = [items firstObject];
    return item.indexPath;
}

- (NSIndexPath *)leftIndexPathOfContentOffset:(CGFloat)contentOffset {
    if (contentOffset == MAXFLOAT) {
        contentOffset = self.collectionView.contentOffset.x;
    }
    CGRect frame = self.collectionView.frame;
    frame.origin.x = contentOffset;
    NSArray *items = [self layoutAttributesForElementsInRect:frame];
    UICollectionViewLayoutAttributes *item = [items firstObject];
    for (UICollectionViewLayoutAttributes *att in items) {
        if (att.frame.origin.x < item.frame.origin.x) {
            item = att;
        }
    }
    return item.indexPath;
}

- (NSInteger)currentSectionContentOffset:(CGFloat)offset {
    NSIndexPath *path = [self firstIndexPathOfContentOffset:offset];
    CGRect frame = [self frameOfSection:path.section];
    
    if (offset < CGRectGetMinX(frame)) {
        return path.section - 1 >= 0 ? path.section - 1 : 0;
    } else if (offset > CGRectGetMaxX(frame)) {
        return path.section + 1 <= [self.collectionView numberOfSections] - 1 ? path.section + 1 : [self.collectionView numberOfSections] - 1;
    } else {
        return path.section;
    }
}

- (CGFloat)sectionPercentOfIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *item = [self layoutAttributesForItemAtIndexPath:indexPath];
    return [self sectionPercentOfContentOffset:item.frame.origin.x];
}

- (CGFloat)sectionPercentOfContentOffset:(CGFloat)offset {
    
    NSInteger secton = [self currentSectionContentOffset:offset];
    CGRect sectionFrame = [self frameOfSection:secton];
    CGFloat currentSectionMaxWidth = sectionFrame.size.width;
    CGFloat currentSectionMinX = sectionFrame.origin.x;
    CGFloat currentSectionMaxX = CGRectGetMaxX(sectionFrame);
    
    if (secton == [self.collectionView numberOfSections] - 1) {
        currentSectionMaxWidth -= self.collectionView.frame.size.width;
    }
    
    CGFloat percent = 0;
    if (currentSectionMaxWidth > 0) {
        percent = (offset - currentSectionMinX) / currentSectionMaxWidth;
    }
    
    return percent;
}

@end
