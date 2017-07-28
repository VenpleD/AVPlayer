//
//  WaitingEvaluationTableViewFootView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "WaitingEvaluationTableViewFootView.h"

@interface WaitingEvaluationTableViewFootView ()
@property (nonatomic, strong) UILabel *timerLabel;
@property (nonatomic, strong) UILabel *numerLabl;
@property (nonatomic, strong) UILabel *allPriceLabel;
@property (nonatomic, strong) UIView *fillView;
@end

@implementation WaitingEvaluationTableViewFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)addSubViews {
    [self.contentView addSubview:self.timerLabel];
    [self.contentView addSubview:self.numerLabl];
    [self.contentView addSubview:self.allPriceLabel];
    [self.contentView addSubview:self.fillView];
}

- (void)updateConstraints {
    [self.timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self.contentView.centerY).offset(-6);
    }];
    
    [self.allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.right).offset(-15);
        make.centerY.equalTo(self.contentView.centerY).offset(-6);
    }];
    
    [self.numerLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.allPriceLabel.left).offset(-10);
        make.centerY.equalTo(self.contentView.centerY).offset(-6);
    }];

    [self.fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(12);
    }];
    

    [super updateConstraints];
}


- (void)setModel:(WaitingEvaluationShopModel *)model {
    _model = model;
    self.timerLabel.text = model.payTimer;
    self.numerLabl.text = [NSString stringWithFormat:@"共%ld件商品",model.goodsModel.count];
    self.allPriceLabel.text = [NSString stringWithFormat:@"合计：￥%.2f",model.allPrice];
    [self renderWithTotalPrice:[NSString stringWithFormat:@"￥%.2f",model.allPrice]];
}

- (void)renderWithTotalPrice:(NSString *)totalPrice {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.allPriceLabel.text attributes:@{NSParagraphStyleAttributeName:paragraphStyle}];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:[self.allPriceLabel.text rangeOfString:totalPrice]];
    [attributedString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]} range:[self.allPriceLabel.text rangeOfString:totalPrice]];
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:@(0.36 * (15 - 12)) range:[self.allPriceLabel.text rangeOfString:self.allPriceLabel.text]];
    self.allPriceLabel.attributedText = attributedString;
    self.allPriceLabel.textAlignment = NSTextAlignmentCenter;
}

- (UILabel *)timerLabel {
    if (!_timerLabel) {
        _timerLabel = [[UILabel alloc]init];
        _timerLabel.font = [UIFont systemFontOfSize:12.0f];
        _timerLabel.textColor = [UIColor colorWithHex:666666];
    }
    return _timerLabel;
}

- (UILabel *)numerLabl {
    if (!_numerLabl) {
        _numerLabl = [[UILabel alloc]init];
        _numerLabl.font = [UIFont systemFontOfSize:12.0f];
        _numerLabl.textColor = [UIColor colorWithHex:666666];
    }
    return _numerLabl;
}

- (UIView *)fillView {
    if (!_fillView) {
        _fillView = [[UIView alloc]init];
        _fillView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _fillView;
}

- (UILabel *)allPriceLabel {
    if (!_allPriceLabel) {
        _allPriceLabel = [[UILabel alloc]init];
        _allPriceLabel.font = [UIFont systemFontOfSize:12.0f];
        _allPriceLabel.textColor = [UIColor colorWithHex:666666];
    }
    return _allPriceLabel;
}


@end
