//
//  PLCommonCollectionViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/24.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "PLCommonCollectionViewController.h"

@interface PLCommonCollectionViewController ()

@property (nonatomic) UICollectionView *collectionView;

@end

@implementation PLCommonCollectionViewController

- (void)dealloc
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
    _collectionView = nil;
}

- (instancetype)init
{
    return [self initWithFlowLayout:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self didInitialize];
    }
    return self;
}

- (instancetype)initWithFlowLayout:(UICollectionViewFlowLayout *)flowLayout
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.flowLayout = flowLayout;
        [self didInitialize];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self.collectionView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - overrite

- (void)initSubviews
{
    [super initSubviews];
    [self initCollectionView];
    [self initEmptyView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutCollectionView];
    [self layoutEmptyView];
}

#pragma mark - CollectionView init & layout

- (void)initCollectionView
{
    if (!self.flowLayout) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceVertical = YES;
    [self.view addSubview:self.collectionView];
}

- (void)layoutCollectionView
{
    self.collectionView.frame = self.view.bounds;
}

#pragma mark - EmptyView init & layout

- (void)initEmptyView
{
    if (!self.emptyView) {
        self.emptyView = [[PLEmptyView alloc] init];
    }
    [self.collectionView addSubview:self.emptyView];
}

- (void)layoutEmptyView
{
    if (!self.emptyView.superview) {
        return;
    }
    
    UIEdgeInsets insets = self.collectionView.contentInset;
    if (@available(iOS 11, *)) {
        if (self.collectionView.contentInsetAdjustmentBehavior != UIScrollViewContentInsetAdjustmentNever) {
            insets = self.collectionView.adjustedContentInset;
        }
    }
    
    self.emptyView.frame = CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds) - (insets.left + insets.right), CGRectGetHeight(self.collectionView.bounds) - (insets.top + insets.bottom));
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentInset"]) {
        [self layoutEmptyView];
    }
}

- (void)scrollViewDidChangeAdjustedContentInset:(UIScrollView *)scrollView
{
    [self layoutEmptyView];
}

#pragma mark - EmptyView Delegate

- (void)emptyView:(PLEmptyView *)view didPressActionButton:(UIButton *)button
{
    
}
- (void)emptyViewDidTouch:(PLEmptyView *)view
{
    
}

#pragma mark - Collection Delegate & DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(100.0f, 100.0f);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
