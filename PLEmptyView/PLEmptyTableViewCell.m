//
//  PLEmptyTableViewCell.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/24.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "PLEmptyTableViewCell.h"

@interface PLEmptyTableViewCell ()
@property (nonatomic) PLEmptyView *emptyView;
@end

@implementation PLEmptyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    [self.contentView addSubview:self.emptyView];
    self.emptyView.frame = self.contentView.bounds;
    self.emptyView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (PLEmptyView *)emptyView
{
    if (!_emptyView) {
        _emptyView = [[PLEmptyView alloc] init];
        [_emptyView setImage:[UIImage imageNamed:@"empty"] ];
        [_emptyView setTitleLabelText:@"哇 没有内容"];
        [_emptyView setDetailLabelText:@"我没有找到您需要的内容，而且我也不知道什么情况"];
    }
    return _emptyView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
