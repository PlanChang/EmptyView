//
//  PLCommonCollectionViewController.h
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/24.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "PLCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLCommonCollectionViewController : PLCommonViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,readonly) UICollectionView *collectionView;

- (void)initCollectionView;
- (void)layoutCollectionView;

@end

NS_ASSUME_NONNULL_END
