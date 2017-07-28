//
//  PaymentTableViewHeaderView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/22.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PaymentTableViewHeaderView.h"

@interface PaymentTableViewHeaderView ()
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation PaymentTableViewHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self payHeaderViewAddSubViews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setImageURL:(NSString *)url allPrice:(CGFloat)price shopName:(NSString *)name {
    if (url) {
        [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:url]];

    }
    self.titleImageView.backgroundColor = [UIColor redColor];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%.2f",price];
    self.nameLabel.text = name;
    
    
}


- (void)payHeaderViewAddSubViews {
    [self addSubview:self.titleImageView];
    [self addSubview:self.priceLabel];
    [self addSubview:self.nameLabel];
}

- (void)updateConstraints {
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(45, 45));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.right).offset(30);
        make.top.equalTo(self.titleImageView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel);
        make.bottom.equalTo(self.titleImageView);
    }];
    
    [super updateConstraints];
}

- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
        _titleImageView.layer.masksToBounds = YES;
        _titleImageView.layer.cornerRadius  =  22.5f;
    }
    return _titleImageView;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont fontWithName:@"Helvetica-light" size:18.f];
        _priceLabel.textColor = [UIColor redColor];
    }
    return _priceLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _nameLabel;
}


@end
