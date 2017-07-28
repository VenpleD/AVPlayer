//
//  OrderPaymentTableViewCell.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/21.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "OrderPaymentTableViewCell.h"

@interface OrderPaymentTableViewCell ()

/// 图片
@property (nonatomic, strong) UIImageView *productImageView;

/// 名称
@property (nonatomic, strong) UILabel *productNameLable;

/// 现价
@property (nonatomic, strong) UILabel *productPriceLable;

/// 原价
@property (nonatomic, strong) UILabel * originalPriceLable;

/// 背景
@property (nonatomic, strong) UIView *shopcartBgView;

///  分割线
@property (nonatomic, strong) UIView *topLineView;

/// 商品数量
@property (nonatomic, strong) UILabel *goodsQtyLabel;

@end

@implementation OrderPaymentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

/// 添加视图
- (void)addSubViews {
    [self.contentView    addSubview:self.shopcartBgView];
    [self.shopcartBgView addSubview:self.productImageView];
    [self.shopcartBgView addSubview:self.productNameLable];
    [self.shopcartBgView addSubview:self.productPriceLable];
    [self.shopcartBgView addSubview:self.topLineView];
    [self.shopcartBgView addSubview:self.originalPriceLable];
    [self.shopcartBgView addSubview:self.goodsQtyLabel];
    
}


- (void)setModel:(GoodsModel *)model {
    _model = model;
    NSLog(@"图片地址是：%@",model.goodsImageUrl);
    NSString *urlStr = [model.goodsImageUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    self.productNameLable.text = model.goodsName;
    self.productPriceLable.text = [NSString stringWithFormat:@"%.2f",model.goodsNewPrice];
    self.originalPriceLable.text = [NSString stringWithFormat:@"%.2f",model.goodsOldPrice];
    [self setOriginalPriceLableText:[NSString stringWithFormat:@"%.2f",model.goodsOldPrice]];
    self.goodsQtyLabel.text = [NSString stringWithFormat:@"x%ld",model.goodsQty];
}


- (UIImageView *)productImageView {
    if (_productImageView == nil){
        _productImageView = [[UIImageView alloc] init];
    }
    return _productImageView;
}

- (UILabel *)productNameLable {
    if (_productNameLable == nil){
        _productNameLable = [[UILabel alloc] init];
        _productNameLable.font = [UIFont systemFontOfSize:14];
        _productNameLable.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
    }
    return _productNameLable;
}



- (UILabel *)productPriceLable {
    if (_productPriceLable == nil){
        _productPriceLable = [[UILabel alloc] init];
        _productPriceLable.font = [UIFont systemFontOfSize:18.0];
        _productPriceLable.textColor = [UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1];
    }
    return _productPriceLable;
}



- (UILabel *)originalPriceLable {
    if (!_originalPriceLable) {
        _originalPriceLable = [[UILabel alloc]init];
        [_originalPriceLable setFont:[UIFont systemFontOfSize:15.0]];
        [_originalPriceLable setTextColor:[UIColor lightGrayColor]];
    }
    return _originalPriceLable;
}

- (UILabel *)goodsQtyLabel {
    if (!_goodsQtyLabel) {
        _goodsQtyLabel = [[UILabel alloc]init];
        [_goodsQtyLabel setFont:[UIFont systemFontOfSize:18]];
    }
    return _goodsQtyLabel;
}


- (void)setOriginalPriceLableText:(NSString *)text {
    NSUInteger length = [text length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:text];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)  range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, length)];
    [self.originalPriceLable setAttributedText:attri];
    
}


- (UIView *)shopcartBgView {
    if (_shopcartBgView == nil){
        _shopcartBgView = [[UIView alloc] init];
        _shopcartBgView.backgroundColor = [UIColor whiteColor];
    }
    return _shopcartBgView;
}

- (UIView *)topLineView {
    if (_topLineView == nil){
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _topLineView;
}

- (void)updateConstraints {

    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self.shopcartBgView);
        make.size.mas_equalTo(CGSizeMake(75, 63));
    }];
    
    [self.productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.right).offset(10);
        make.top.equalTo(10);
    }];
 
    [self.productPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.right).offset(10);
        make.bottom.equalTo(self.productImageView);
    }];
    
    [self.originalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productPriceLable.right).offset(5);
        make.bottom.equalTo(self.productPriceLable);
    }];
    
    [self.shopcartBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.goodsQtyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.shopcartBgView.right).offset(-15);
        make.bottom.equalTo(self.productPriceLable);
    }];
    
    
    
    [super updateConstraints];
}

@end
