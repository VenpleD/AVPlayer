//
//  CartTableViewCell.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/9.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "CartTableViewCell.h"
#import "ShopcartCountView.h"
@interface CartTableViewCell ()

/**
 选择按钮
 */
@property (nonatomic, strong) UIButton *productSelectButton;

/**
 图片
 */
@property (nonatomic, strong) UIImageView *productImageView;

/**
 名称
 */
@property (nonatomic, strong) UILabel *productNameLable;

/**
 规格
 */
@property (nonatomic, strong) UILabel *productSizeLable;

/**
 现价
 */
@property (nonatomic, strong) UILabel *productPriceLable;

/**
 原价
 */
@property (nonatomic, strong) UILabel * originalPriceLable;

/**
 背景
 */
@property (nonatomic, strong) UIView *shopcartBgView;

/**
 分割线
 */
@property (nonatomic, strong) UIView *topLineView;

/**
 编辑状态的视图
 */
@property (nonatomic, strong) ShopcartCountView *editView;

/**
 商品数量
 */
@property (nonatomic, strong) UILabel *goodsQtyLabel;




@end

@implementation CartTableViewCell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setupViews {
    [self.contentView    addSubview:self.shopcartBgView];
    [self.shopcartBgView addSubview:self.productSelectButton];
    [self.shopcartBgView addSubview:self.productImageView];
    [self.shopcartBgView addSubview:self.productNameLable];
    [self.shopcartBgView addSubview:self.productSizeLable];
    [self.shopcartBgView addSubview:self.productPriceLable];
    [self.shopcartBgView addSubview:self.topLineView];
    [self.shopcartBgView addSubview:self.originalPriceLable];
    [self.shopcartBgView addSubview:self.goodsQtyLabel];
    [self.contentView addSubview:self.editView];
    [self.contentView bringSubviewToFront:self.editView];

}

- (void)configureShopcartCellWithProductURL:(NSString *)productURL
                                productName:(NSString *)productName
                               productColor:(NSString *)productColor
                                productSize:(NSString *)productSize
                     productRecommendedSize:(NSString *)productRecommendedSize
                               productPrice:(CGFloat)productPrice
                            productOldPrice:(CGFloat)oldPrice
                               productCount:(NSInteger)productCount
                               productStock:(NSInteger)productStock
                            productSelected:(BOOL)productSelected
                                    editing:(BOOL)edit {
    
    NSURL *encodingURL = [NSURL URLWithString:[productURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    [self.productNameLable setText:productName];

    productColor = productColor == nil ? @"" : productColor;
    productSize = productSize == nil ? @"" : productSize;
    productRecommendedSize = productRecommendedSize == nil ? @"" : productRecommendedSize;
    
    NSString *goodsSpecifications = [NSString stringWithFormat:@"%@;%@(%@)",productColor,productSize,productRecommendedSize];
    [self.productSizeLable setText:goodsSpecifications];
    [self.productImageView sd_setImageWithURL:encodingURL];
    [self.productPriceLable setText:[NSString stringWithFormat:@"￥%.2f", productPrice]];
    [self.originalPriceLable setText:[NSString stringWithFormat:@"%.2f",oldPrice]];
    [self.productSelectButton setSelected:productSelected];
    [self.goodsQtyLabel setText:[NSString stringWithFormat:@"×%ld",productCount]];
    [self cartCellEditing:edit];
    [self setOriginalPriceLableText:[NSString stringWithFormat:@"%.2f",oldPrice]];
    [self.editView configureShopcartCountViewWithProductCount:productCount productStock:productStock goodsSpecifications:goodsSpecifications];
}

- (void)cartCellEditing:(BOOL)isEdit {
    self.editView.hidden = !isEdit;
    self.productNameLable.hidden = isEdit;
    self.productSizeLable.hidden = isEdit;
    self.productPriceLable.hidden = isEdit;
}


- (void)productSelectButtonAction {
    self.productSelectButton.selected = !self.productSelectButton.isSelected;
    if (self.shopcartCellBlock) {
        self.shopcartCellBlock(self.productSelectButton.selected);
    }
}

- (UIButton *)productSelectButton
{
    if(_productSelectButton == nil)
    {
        _productSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_productSelectButton setImage:[UIImage imageNamed:@"未选中按钮-01"] forState:UIControlStateNormal];
        [_productSelectButton setImage:[UIImage imageNamed:@"单选按钮-选中"] forState:UIControlStateSelected];
        [_productSelectButton addTarget:self action:@selector(productSelectButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _productSelectButton;
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

- (UILabel *)productSizeLable {
    if (_productSizeLable == nil){
        _productSizeLable = [[UILabel alloc] init];
        _productSizeLable.font = [UIFont systemFontOfSize:13];
        _productSizeLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    }
    return _productSizeLable;
}

- (UILabel *)productPriceLable {
    if (_productPriceLable == nil){
        _productPriceLable = [[UILabel alloc] init];
        _productPriceLable.font = [UIFont systemFontOfSize:18.0];
        _productPriceLable.textColor = [UIColor colorWithRed:0.918  green:0.141  blue:0.137 alpha:1];
    }
    return _productPriceLable;
}

- (UIView *)editView {
    if (!_editView) {
        _editView = [[ShopcartCountView alloc]initWithFrame:CGRectZero];
        [_editView setBackgroundColor:[UIColor whiteColor]];
        _editView.hidden = YES;
        WEAK_SELF(self)
                _editView.shopcartCountViewEditBlock = ^(NSInteger count){
        STRONG_SELF(self)
                    if (self.shopcartCellEditBlock) {
                        self.shopcartCellEditBlock(count);
                    }
                };
    }
    return _editView;
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
    
    [self.productSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self.shopcartBgView).offset(-20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.productImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(50);
        make.centerY.equalTo(self.shopcartBgView);
        make.size.mas_equalTo(CGSizeMake(75, 63));
    }];

    [self.productNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.right).offset(10);
        make.top.equalTo(10);
    }];

    [self.productSizeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.right).offset(10);
        make.top.equalTo(self.productNameLable.bottom);
    }];

    [self.productPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productImageView.right).offset(10);
        make.top.equalTo(self.productSizeLable.bottom).offset(5);
    }];

    [self.originalPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.productPriceLable.right).offset(5);
        make.bottom.equalTo(self.productPriceLable);
    }];
    
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.bounds.size.width - 125);
        make.top.right.bottom.equalTo(0);
        
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
