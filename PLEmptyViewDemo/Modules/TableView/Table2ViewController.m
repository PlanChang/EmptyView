//
//  Table2ViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/24.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "Table2ViewController.h"

@interface Table2ViewController ()

@end

@implementation Table2ViewController

- (void)initSubviews
{
    [super initSubviews];
    
    UILabel *headerView = [UILabel new];
    headerView.text = @"tableView header";
    headerView.textAlignment = NSTextAlignmentCenter;
    headerView.frame = CGRectMake(0,0,self.view.frame.size.width,50);
    self.tableView.tableHeaderView = headerView;
}

@end
