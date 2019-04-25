//
//  PLEmptyTableViewCell.h
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/24.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PLEmptyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLEmptyTableViewCell : UITableViewCell
@property (nonatomic,readonly) PLEmptyView *emptyView;
@end

NS_ASSUME_NONNULL_END
