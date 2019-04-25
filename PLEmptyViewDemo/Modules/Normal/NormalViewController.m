
//
//  NormalViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/22.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "NormalViewController.h"

@interface NormalViewController () <PLEmptyViewDelegate>
@end

@implementation NormalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Normal Controller";
    [self initSubviews];
}

- (void)initSubviews
{
    [super initSubviews];
    [self.view addSubview:self.emptyView];
    
    [self.emptyView setImage:[UIImage imageNamed:@"empty"] ];
    [self.emptyView setTitleLabelText:@"哇 没有内容"];
    [self.emptyView setDetailLabelText:@"我没有找到您需要的内容，而且我也不知道什么情况"];
    [self.emptyView setActionButtonTitle:@"刷新一下，看看人品？"];
    
    self.emptyView.actionButtonRoundCorners = YES;
    
    self.emptyView.titleLabelFont = [UIFont boldSystemFontOfSize:15];
    self.emptyView.detailLabelFont = [UIFont systemFontOfSize:14];
    self.emptyView.actionButtonFont = [UIFont systemFontOfSize:15];
    
    self.emptyView.imageViewInsets = UIEdgeInsetsMake(20, 100, 10, 100);
    self.emptyView.titleLabalInsets = UIEdgeInsetsMake(15, 0, 0, 0);
    self.emptyView.detailLabalInsets = UIEdgeInsetsMake(15, 80, 30, 80);
    self.emptyView.actionButtonInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    self.emptyView.actionButton.contentEdgeInsets = UIEdgeInsetsMake(10, 30, 10, 30);
    self.emptyView.delegate = self;
    [self showEmptyView];
}

- (void)emptyViewDidTouch:(PLEmptyView *)view
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)emptyView:(PLEmptyView *)view didPressActionButton:(UIButton *)button
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
