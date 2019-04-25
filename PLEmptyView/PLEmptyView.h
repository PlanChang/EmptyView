//
//  PLEmptyView.h
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/2.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PLEmptyView;
@protocol PLEmptyViewDelegate <NSObject>

- (void)emptyView:(PLEmptyView *)view didPressActionButton:(UIButton *)button;
- (void)emptyViewDidTouch:(PLEmptyView *)view;

@end

@interface PLEmptyView : UIView

///大图片
@property (nonatomic,readonly) UIImageView *imageView;
///提示标题
@property (nonatomic,readonly) UILabel *titleLabel;
///提示说明
@property (nonatomic,readonly) UILabel *detailLabel;
///按钮
@property (nonatomic,readonly) UIButton *actionButton;

///按钮和touch事件代理
@property (nonatomic,weak) id <PLEmptyViewDelegate> delegate;

///按钮圆角
@property (nonatomic,assign) BOOL actionButtonRoundCorners;

///竖向偏移
@property (nonatomic,assign) CGFloat verticalOffset;

///内容四周的边距
@property (nonatomic,assign) UIEdgeInsets contentInsets;
@property (nonatomic,assign) UIEdgeInsets imageViewInsets;
@property (nonatomic,assign) UIEdgeInsets titleLabalInsets;
@property (nonatomic,assign) UIEdgeInsets detailLabalInsets;
@property (nonatomic,assign) UIEdgeInsets actionButtonInsets;

///文字内容的字体
@property (nonatomic,strong) UIFont *titleLabelFont;
@property (nonatomic,strong) UIFont *detailLabelFont;
@property (nonatomic,strong) UIFont *actionButtonFont;

///文字内容的颜色
@property (nonatomic,strong) UIColor *titleLabelTextColor;
@property (nonatomic,strong) UIColor *detailLabelTextColor;
@property (nonatomic,strong) UIColor *actionButtonTitleColor;

///设置内容：设置为空或不设置会隐藏
- (void)setImage:(UIImage *)image;
- (void)setTitleLabelText:(NSString *)text;
- (void)setDetailLabelText:(NSString *)detailText;
///设置buttonTitle：button大小通过button.contentEdgeInsets设置
- (void)setActionButtonTitle:(NSString *)title;
- (void)setActionButtonImage:(UIImage *)image;
///获取内容区域的大小
- (CGSize)sizeThatContentViewFits;

@end

NS_ASSUME_NONNULL_END
