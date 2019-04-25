//
//  PLCommonViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/21.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "PLCommonViewController.h"

@interface PLCommonViewController ()

@end

@implementation PLCommonViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self didInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self didInitialize];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubviews];
    [self layoutSubviews];
}

#pragma mark - Public Api

- (void)didInitialize
{
    
}

- (void)initSubviews
{
    
}

- (void)layoutSubviews
{
    
}

- (void)initEmptyView
{
    if (!self.emptyView) {
        self.emptyView = [[PLEmptyView alloc] init];
    }
    [self.view addSubview:self.emptyView];
}

- (void)layoutEmptyView
{
    if (!self.emptyView.superview) {
        return;
    }
    
    self.emptyView.frame = self.view.bounds;
    self.emptyView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)showEmptyView
{
    [self initEmptyView];
    [self layoutEmptyView];
}

- (void)hideEmptyView
{
    [self.emptyView removeFromSuperview];
}

#pragma mark - EmptyView Action

- (void)emptyView:(PLEmptyView *)view didPressActionButton:(UIButton *)button
{
    
}
- (void)emptyViewDidTouch:(PLEmptyView *)view
{
    
}

#pragma mark - Lazy

- (PLEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[PLEmptyView alloc] init];
        _emptyView.delegate = self;
    }
    return _emptyView;
}

@end
