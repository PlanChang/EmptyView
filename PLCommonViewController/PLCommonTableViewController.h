//
//  PLCommonTableViewController.h
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/23.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "PLCommonViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLCommonTableViewController : PLCommonViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,readonly) UITableView *tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;

- (void)initTableView;
- (void)layoutTableView;

@end

NS_ASSUME_NONNULL_END
