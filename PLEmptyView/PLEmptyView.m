//
//  PLEmptyView.m
//  PLEmptyViewDemo
//
//  Created by changshitong on 2019/4/2.
//  Copyright © 2019 PLAN. All rights reserved.
//

#import "PLEmptyView.h"

/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

@interface UIView (SetRect)
- (void)pl_setHeight:(CGFloat)height;
@end

@implementation UIView (SetRect)

- (void)pl_setHeight:(CGFloat)height
{
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

@end


@interface PLEmptyView ()

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *detailLabel;
@property (nonatomic) UIButton *actionButton;
@property (nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation PLEmptyView

- (void)dealloc
{
    _scrollView = nil;
    _tapGesture = nil;
    _contentView = nil;
    _imageView = nil;
    _titleLabel = nil;
    _detailLabel = nil;
    _actionButton = nil;
}

#pragma mark - Init

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

#pragma mark - UI

- (void)initSubviews
{
    self.actionButtonRoundCorners = YES;
    
    self.titleLabelFont = [UIFont boldSystemFontOfSize:15];
    self.detailLabelFont = [UIFont systemFontOfSize:14];
    self.actionButtonFont = [UIFont systemFontOfSize:15];
    
    self.imageViewInsets = UIEdgeInsetsMake(20, 100, 10, 100);
    self.titleLabalInsets = UIEdgeInsetsMake(15, 0, 0, 0);
    self.detailLabalInsets = UIEdgeInsetsMake(15, 80, 30, 80);
    self.actionButtonInsets = UIEdgeInsetsMake(0, 0, 20, 0);
    self.actionButton.contentEdgeInsets = UIEdgeInsetsMake(10, 30, 10, 30);
    
    self.backgroundColor = UIColor.whiteColor;
    self.scrollView.backgroundColor = UIColor.clearColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.actionButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    
    CGSize contentViewSize = [self sizeThatContentViewFits];
    self.contentView.frame = CGRectMake(0, CGRectGetMidY(self.scrollView.bounds) - contentViewSize.height / 2 + self.verticalOffset, contentViewSize.width, contentViewSize.height);
    
    if (CGRectGetHeight(self.contentView.bounds) > CGRectGetHeight(self.scrollView.bounds)) {
        CGRect rect = self.contentView.frame;
        rect.origin.y = self.verticalOffset;
        self.contentView.frame = rect;
        self.scrollView.bounces = YES;
    } else {
        self.scrollView.bounces = NO;
    }
    
    self.scrollView.contentSize = CGSizeMake(fmax(CGRectGetWidth(self.scrollView.bounds) - UIEdgeInsetsGetHorizontalValue(self.scrollView.contentInset), contentViewSize.width), fmax(CGRectGetHeight(self.scrollView.bounds) - UIEdgeInsetsGetVerticalValue(self.scrollView.contentInset), CGRectGetMaxY(self.contentView.frame)));
    
    CGFloat originY = 0.0f;
    if (!self.imageView.hidden) {
        [self.imageView sizeToFit];
        self.imageView.frame = CGRectMake(self.imageViewInsets.left, originY +self.imageViewInsets.top, CGRectGetWidth(self.imageView.frame), CGRectGetHeight(self.imageView.frame));
        self.imageView.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0, self.imageView.center.y);
        originY = CGRectGetMaxY(self.imageView.frame) + self.imageViewInsets.bottom;
    }
    
    if (!self.titleLabel.hidden) {
        self.titleLabel.frame = CGRectMake(self.titleLabalInsets.left, originY + self.titleLabalInsets.top, CGRectGetWidth(self.contentView.frame) -UIEdgeInsetsGetHorizontalValue(self.titleLabalInsets), CGRectGetHeight(self.titleLabel.frame));
        originY = CGRectGetMaxY(self.titleLabel.frame) + self.titleLabalInsets.bottom;
    }
    
    if (!self.detailLabel.hidden) {
        self.detailLabel.frame = CGRectMake(self.detailLabalInsets.left, originY + self.detailLabalInsets.top, CGRectGetWidth(self.contentView.frame) -UIEdgeInsetsGetHorizontalValue(self.detailLabalInsets), CGRectGetHeight(self.detailLabel.frame));
        originY = CGRectGetMaxY(self.detailLabel.frame) + self.detailLabalInsets.bottom;
    }
    
    if (!self.actionButton.hidden) {
        [self.actionButton sizeToFit];
        CGRect rect = self.actionButton.frame;
        rect.origin.y = originY + self.actionButtonInsets.top;
        self.actionButton.frame = rect;
        self.actionButton.center = CGPointMake(CGRectGetWidth(self.contentView.frame)/2.0, self.actionButton.center.y);
        originY = CGRectGetMaxY(self.actionButton.frame) + self.actionButtonInsets.bottom;
        
        //button rounded corners style
        self.actionButton.clipsToBounds = self.actionButtonRoundCorners;
        if (self.actionButtonRoundCorners) {
            self.actionButton.layer.cornerRadius = CGRectGetHeight(self.actionButton.frame)/2.0;
        }
    }
}

#pragma mark - Getter

#pragma mark - Setter

- (void)setActionButtonRoundCorners:(BOOL)actionButtonRoundCorners
{
    _actionButtonRoundCorners = actionButtonRoundCorners;
    [self setNeedsLayout];
}

/// Content Vertical Offset

- (void)setVerticalOffset:(CGFloat)verticalOffset
{
    _verticalOffset = verticalOffset;
    [self setNeedsLayout];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    self.scrollView.contentInset = contentInsets;
    [self setNeedsLayout];
}

- (void)setImageViewInsets:(UIEdgeInsets)imageViewInsets
{
    _imageViewInsets = imageViewInsets;
    [self setNeedsLayout];
}

- (void)setTitleLabalInsets:(UIEdgeInsets)titleLabalInsets
{
    _titleLabalInsets = titleLabalInsets;
    [self setNeedsLayout];
}

/// Font Setter

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    if (titleLabelFont) {
        self.titleLabel.font = titleLabelFont;
    }
    [self setNeedsLayout];
}

- (void)setDetailLabelFont:(UIFont *)detailLabelFont
{
    if (detailLabelFont) {
        self.detailLabel.font = detailLabelFont;
        [self updateDetailTextLabelWithText:self.detailLabel.text];
    }
}

- (void)setActionButtonFont:(UIFont *)actionButtonFont
{
    if (actionButtonFont) {
        self.actionButton.titleLabel.font = actionButtonFont;
        [self setNeedsLayout];
    }
}

/// Color Setter

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    if (titleLabelTextColor) {
        self.titleLabel.textColor = titleLabelTextColor;
    }
}

- (void)setDetailLabelTextColor:(UIColor *)detailLabelTextColor
{
    if (detailLabelTextColor) {
        self.detailLabelTextColor = detailLabelTextColor;
    }
}

- (void)setActionButtonTitleColor:(UIColor *)actionButtonTitleColor
{
    if (actionButtonTitleColor) {
        [self.actionButton setTitleColor:actionButtonTitleColor forState:UIControlStateNormal];
    }
}

/// Content Setter

- (void)setImage:(UIImage *)image
{
    self.imageView.hidden = !image;
    if (image) {
        self.imageView.image = image;
    }
    [self setNeedsLayout];
}

- (void)setTitleLabelText:(NSString *)text
{
    self.titleLabel.hidden = !text;
    self.titleLabel.text = text;
    [self setNeedsLayout];
}

- (void)setDetailLabelText:(NSString *)detailText
{
    [self updateDetailTextLabelWithText:detailText];
}

- (void)setActionButtonTitle:(NSString *)title
{
    self.actionButton.hidden = !title;
    [self.actionButton setTitle:title forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)setActionButtonImage:(UIImage *)image;
{
    self.actionButton.hidden = !image;
    [self.actionButton setImage:image forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (void)setActionButtonBlock:(void(^)(UIButton *actionButton))block
{
    self.actionButtonBlock = block;
}

#pragma mark - Action Button Events

- (void)actionButtonTouchEvent:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(emptyView:didPressActionButton:)]) {
        [self.delegate emptyView:self didPressActionButton:button];
    }
}

- (void)tapGestureAction
{
    if ([self.delegate respondsToSelector:@selector(emptyViewDidTouch:)]) {
        [self.delegate emptyViewDidTouch:self];
    }
}

#pragma mark - contentViewSize

- (CGSize)sizeThatContentViewFits
{
    CGFloat resultHeight = 0;
    
    CGFloat resultWidth = [self contentWidth];
    if (!self.imageView.hidden) {
        CGFloat imageViewOriginalHeight = [self.imageView sizeThatFits:CGSizeMake([self contentWidth] - UIEdgeInsetsGetHorizontalValue(self.imageViewInsets), CGFLOAT_MAX)].height;
        [self.imageView pl_setHeight:imageViewOriginalHeight];
        CGFloat imageViewHeight = imageViewOriginalHeight + UIEdgeInsetsGetVerticalValue(self.imageViewInsets);
        resultHeight += imageViewHeight;
    }
    
    if (!self.titleLabel.hidden) {
        CGFloat textLabelOriginalHeight = [self.titleLabel sizeThatFits:CGSizeMake([self contentWidth] - UIEdgeInsetsGetHorizontalValue(self.titleLabalInsets), CGFLOAT_MAX)].height;
        [self.titleLabel pl_setHeight:textLabelOriginalHeight];
        CGFloat textLabelHeight = textLabelOriginalHeight + UIEdgeInsetsGetVerticalValue(self.titleLabalInsets);
        resultHeight += textLabelHeight;
    }
    
    if (!self.detailLabel.hidden) {
        CGFloat detailTextLabelOriginalHeight = [self.detailLabel sizeThatFits:CGSizeMake([self contentWidth] - UIEdgeInsetsGetHorizontalValue(self.detailLabalInsets), CGFLOAT_MAX)].height;
        [self.detailLabel pl_setHeight:detailTextLabelOriginalHeight];
        CGFloat detailTextLabelHeight = detailTextLabelOriginalHeight + UIEdgeInsetsGetVerticalValue(self.detailLabalInsets);
        resultHeight += detailTextLabelHeight;
    }
    
    if (!self.actionButton.hidden) {
        CGFloat actionButtonOriginalHeight = [self.actionButton sizeThatFits:CGSizeMake([self contentWidth] - UIEdgeInsetsGetHorizontalValue(self.actionButtonInsets), CGFLOAT_MAX)].height;
        [self.actionButton pl_setHeight:actionButtonOriginalHeight];
        CGFloat actionButtonHeight = actionButtonOriginalHeight + UIEdgeInsetsGetVerticalValue(self.actionButtonInsets);
        resultHeight += actionButtonHeight;
    }
    
    return CGSizeMake(resultWidth, resultHeight);
}

#pragma mark - Private

//内容区域宽度
- (CGFloat)contentWidth
{
    return CGRectGetWidth(self.scrollView.bounds) -  UIEdgeInsetsGetVerticalValue(self.scrollView.contentInset);
}

- (void)updateDetailTextLabelWithText:(NSString *)text
{
    if (text.length > 0 && self.detailLabel.font) {
        NSMutableAttributedString *detail = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.maximumLineHeight = self.detailLabel.font.pointSize*1.5;
        style.minimumLineHeight = self.detailLabel.font.pointSize*1.5;
        style.alignment = NSTextAlignmentCenter;
        [detail addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
        self.detailLabel.attributedText = detail;
    }
    self.detailLabel.hidden = !text;
    [self setNeedsLayout];
}

#pragma mark - Lazy Init

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_scrollView addGestureRecognizer:self.tapGesture];
        [self.tapGesture requireGestureRecognizerToFail:_scrollView.panGestureRecognizer];
    }
    return _scrollView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.hidden = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.hidden = YES;
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = UIColor.blackColor;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.hidden = YES;
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = UIColor.grayColor;
        _detailLabel.numberOfLines = 0;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _detailLabel;
}

- (UIButton *)actionButton
{
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionButton.backgroundColor = UIColor.blackColor;
        _actionButton.hidden = YES;
        [_actionButton addTarget:self action:@selector(actionButtonTouchEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionButton;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction)];
    }
    return _tapGesture;
}

@end
