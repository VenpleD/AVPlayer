//
//  OrderPaymentBottomView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/21.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "OrderPaymentBottomView.h"
@interface OrderPaymentBottomView ()
@property (nonatomic, strong) UILabel *footingLabel;
@property (nonatomic, strong) UILabel *allPriceLabel;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation OrderPaymentBottomView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

/// 添加view
- (void)addSubviews {
    [self addSubview:self.footingLabel];
    [self addSubview:self.allPriceLabel];
    [self addSubview:self.submitButton];
}

- (void)updateConstraints {
    [self.footingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self);
    }];
    
    [self.allPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.footingLabel.right).offset(0);
        make.bottom.equalTo(self.footingLabel);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(0);
        make.width.equalTo(kSCREEN_WIDTH * 0.32);
    }];
    
    [super updateConstraints];
}


- (void)setAllprice:(NSInteger)price {
    self.allPriceLabel.text = [NSString stringWithFormat:@"￥%ld",price];
    NSString *tempStr = self.allPriceLabel.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 1)];
    NSRange markRange = [tempStr rangeOfString:@"￥"];
    [strAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:markRange];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:12.0] range:markRange];
    self.allPriceLabel.attributedText = strAtt;
}

- (void)submit {
    !self.submitBlcok ? : self.submitBlcok();
}

- (UILabel *)footingLabel {
    if (!_footingLabel) {
        _footingLabel = [[UILabel alloc]init];
        _footingLabel.text = @"合计：";
        _footingLabel.font = [UIFont systemFontOfSize:14.0f];
        _footingLabel.textColor = [UIColor blackColor];
    }
    return _footingLabel;
}

- (UILabel *)allPriceLabel {
    if (!_allPriceLabel) {
        _allPriceLabel = [[UILabel alloc]init];
        _allPriceLabel.font = [UIFont systemFontOfSize:18.0f];
        _allPriceLabel.textColor = [UIColor redColor];
    }
    return _allPriceLabel;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.backgroundColor = [UIColor redColor];
        [_submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}


@end
