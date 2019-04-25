//
//  ViewController.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/2.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "HomeViewController.h"
#import "NormalViewController.h"
#import "TableViewViewController.h"
#import "Table2ViewController.h"
#import "EmptyCellViewController.h"
#import "CollectionViewController.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) NSArray *dataSource;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Dome List";
    self.dataSource = @[@"Normal",@"TableView",@"TableView has header",@"CollectionView",@"TableViewCell"];
    [self initSubviews];
}

#pragma mark - UI

- (void)initSubviews
{
    [self.view addSubview:self.tableView];
    self.tableView.frame = self.view.bounds;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

#pragma mark - TableView Delegate & DataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case 0:
            [self gotoNormalVC];
            break;
        case 1:
            [self gotoTableViewVC];
            break;
        case 2:
            [self gotoHeaderTableViewVC];
            break;
        case 3:
            [self gotoCollectionVC];
            break;
        case 4:
            [self gotoEmptyCellVC];
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"(%ld) %@",indexPath.section+1,self.dataSource[indexPath.section]];
    return cell;
}

#pragma mark - Push

- (void)gotoNormalVC
{
    NormalViewController *vc = [[NormalViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoTableViewVC
{
    TableViewViewController *vc = [[TableViewViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.title = @"Table View Controller";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoHeaderTableViewVC
{
    Table2ViewController *vc = [[Table2ViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.title = @"Header & Table View Controller";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoEmptyCellVC
{
    EmptyCellViewController *vc = [[EmptyCellViewController alloc] initWithStyle:UITableViewStyleGrouped];
    vc.title = @"Empty Cell Controller";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoCollectionVC
{
    CollectionViewController *vc = [[CollectionViewController alloc] init];
    vc.title = @"Collection View Controller";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Lazy

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

@end
