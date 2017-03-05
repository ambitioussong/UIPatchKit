//
//  UICollectionViewCell+PKAdd.h
//  UIPatchKit
//
//  Created by cc on 16/11/21.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, FKCollectionViewCellState) {
    FKCollectionViewCellStateNormal = 0,
    FKCollectionViewCellStateDelete,
};

typedef void(^DeleteAction)(void);

@interface UICollectionViewCell (PKAdd)

- (void)setDeleteAction:(DeleteAction)block;

- (void)enterDeleteState;
- (void)leaveDeleteState;

@end
