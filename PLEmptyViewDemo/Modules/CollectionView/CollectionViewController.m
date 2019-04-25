//
//  CollectionViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/24.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "CollectionViewController.h"

@implementation CollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.collectionView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"cell"];
    
    [self.emptyView setImage:[UIImage imageNamed:@"empty"] ];
    [self.emptyView setTitleLabelText:@"哇 没有内容"];
    [self.emptyView setDetailLabelText:@"我没有找到您需要的内容，而且我也不知道什么情况"];
    [self.emptyView setActionButtonTitle:@"刷新一下，看看人品？"];
    
    self.emptyView.delegate = self;
    [self showEmptyView];
}

- (void)initSubviews
{
    [super initSubviews];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(refreshAction)];
    [self.navigationItem setRightBarButtonItem:item];
}

- (void)refreshAction
{
    if (self.emptyView.superview) {
        [self hideEmptyView];
    } else {
        [self showEmptyView];
    }
}

#pragma mark - EmptyView Delegate

- (void)emptyView:(PLEmptyView *)view didPressActionButton:(UIButton *)button
{
    [self refreshAction];
}
- (void)emptyViewDidTouch:(PLEmptyView *)view
{
    [self refreshAction];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100.0f, 100.0f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.grayColor;
    return cell;
}

@end
