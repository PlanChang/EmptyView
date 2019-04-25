//
//  PLCommonViewController.h
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/21.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLCommonViewController : UIViewController <PLEmptyViewDelegate>

///空白页
@property (nonatomic) PLEmptyView *emptyView;

/*
 实例化完成后调用
 */
- (void)didInitialize NS_REQUIRES_SUPER;

/*
 创建子视图 布局子视图
 */
- (void)initSubviews NS_REQUIRES_SUPER;
- (void)layoutSubviews NS_REQUIRES_SUPER;

/*
 创建空白页 布局空白页
 */
- (void)initEmptyView;
- (void)layoutEmptyView;

/*
 显/隐空白页
 */
- (void)showEmptyView;
- (void)hideEmptyView;

@end

NS_ASSUME_NONNULL_END
