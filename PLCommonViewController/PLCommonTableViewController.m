//
//  PLCommonTableViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/23.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "PLCommonTableViewController.h"

@interface PLCommonTableViewController ()
@property (nonatomic,assign) UITableViewStyle style;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation PLCommonTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithNibName:nil bundle:nil]) {
        self.style = style;
        [self didInitialize];
    }
    return self;
}

- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.style = UITableViewStylePlain;
        [self didInitialize];
    }
    return self;
}

- (void)dealloc
{
    _tableView.dataSource = nil;
    _tableView.delegate = nil;
    [_tableView removeObserver:self forKeyPath:@"contentInset"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addObserver:self forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - overrite

- (void)initSubviews
{
    [super initSubviews];
    [self initTableView];
    [self initEmptyView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self layoutTableView];
    [self layoutEmptyView];
}

#pragma mark - TableView init & layout

- (void)initTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.style];
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
}

- (void)layoutTableView
{
    self.tableView.frame = self.view.bounds;
}

#pragma mark - EmptyView init & layout

- (void)initEmptyView
{
    if (!self.emptyView) {
        self.emptyView = [[PLEmptyView alloc] init];
        self.emptyView.delegate = self;
    }
    [self.tableView addSubview:self.emptyView];
}

- (void)layoutEmptyView
{
    if (!self.emptyView || !self.emptyView.superview) {
        return;
    }
    
    UIEdgeInsets insets = self.tableView.contentInset;
    if (@available(iOS 11, *)) {
        if (self.tableView.contentInsetAdjustmentBehavior != UIScrollViewContentInsetAdjustmentNever) {
            insets = self.tableView.adjustedContentInset;
        }
    }
    
    if (self.tableView.tableHeaderView) {
        self.emptyView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.tableHeaderView.frame), CGRectGetWidth(self.tableView.bounds) - (insets.left + insets.right), CGRectGetHeight(self.tableView.bounds) - (insets.top + insets.bottom) - CGRectGetMaxY(self.tableView.tableHeaderView.frame));
    } else {
        self.emptyView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds) - (insets.left + insets.right), CGRectGetHeight(self.tableView.bounds) - (insets.top + insets.bottom));
    }
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

#pragma mark - TableView Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.style == UITableViewStylePlain) {
        return 0.0f;
    } else {
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.style == UITableViewStylePlain) {
        return 0.0f;
    } else {
        return CGFLOAT_MIN;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
