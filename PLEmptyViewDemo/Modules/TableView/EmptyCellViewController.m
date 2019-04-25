//
//  EmptyCellViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/24.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "EmptyCellViewController.h"
#import "PLEmptyTableViewCell.h"

@interface EmptyCellViewController ()

@end

@implementation EmptyCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hideEmptyView];
}

- (void)initTableView
{
    [super initTableView];
    [self.tableView registerClass:PLEmptyTableViewCell.class forCellReuseIdentifier:@"emptyCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 300;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        PLEmptyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"emptyCell" forIndexPath:indexPath];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"No.%ld cell",indexPath.row];
    return cell;
}

@end
