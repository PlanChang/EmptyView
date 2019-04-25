//
//  TableViewViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/23.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "TableViewViewController.h"

@interface TableViewViewController () <PLEmptyViewDelegate>

@end

@implementation TableViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (void)initTableView
{
    [super initTableView];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellIdentifier];
}

- (void)refreshAction
{
    if (self.emptyView.superview) {
        [self hideEmptyView];
    } else {
        [self showEmptyView];
    }
}

- (void)emptyViewDidTouch:(PLEmptyView *)view
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)emptyView:(PLEmptyView *)view didPressActionButton:(UIButton *)button
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self refreshAction];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"No.%ld cell",indexPath.row];
    return cell;
}

@end
