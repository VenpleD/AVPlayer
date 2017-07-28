//
//  PaymentTableViewCell.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/22.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PaymentTableViewCell.h"

@interface PaymentTableViewCell ()
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailsLabel;
@property (nonatomic, strong) UIImageView *selectImageView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PaymentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}


- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    if (isSelect) {
        self.selectImageView.image = [UIImage imageNamed:@"select"];
    } else {
         self.selectImageView.image = [UIImage imageNamed:@"unSelect"];
    }
}

- (void)titleImage:(UIImage *)titleImage
       titleString:(NSString *)titleString
     goodsAllPrice:(CGFloat)price {
    self.titleImageView.image = titleImage;
    self.nameLabel.text = titleString;
    if ([titleString isEqualToString:@"积分支付"]) {
        self.detailsLabel.text = [NSString stringWithFormat:@"(需%.2f元=%.2f积分)",price , price * 2];
    }
    if ([titleString isEqualToString:@"银联支付"]) {
        self.detailsLabel.text = [NSString stringWithFormat:@"(需%.2f元)",price];
        
        ///银联暂未开放
        self.titleImageView.image = [UIImage imageNamed:@"union_pay_gray"];
    }
}

- (void)setIsLastLine:(BOOL)isLastLine {
    _isLastLine = isLastLine;
    self.lineView.hidden = isLastLine;
}

- (void)addSubViews {
    [self.contentView addSubview:self.titleImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.detailsLabel];
    [self.contentView addSubview:self.selectImageView];
    [self.contentView addSubview:self.lineView];
}

- (void)updateConstraints {
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(24, 24));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.right).offset(10);
        make.centerY.equalTo(self.titleImageView);
    }];
    
    [self.detailsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.right).offset(5);
        make.centerY.equalTo(self.nameLabel);
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(0);
        make.left.equalTo(15);
        
        
        make.height.equalTo(0.5);
    }];
    
    
    [super updateConstraints];
}

- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc]init];
    }
    return _titleImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:16.0f];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

-(UILabel *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc]init];
        _detailsLabel.textColor = [UIColor colorWithHexString:@"cccccc"];
        _detailsLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _detailsLabel;
}

-(UIImageView *)selectImageView {
    if (!_selectImageView) {
        _selectImageView = [[UIImageView alloc]init];
    }
    return _selectImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"cccccc"];
    }
    return _lineView;
}

@end

