//
//  OrderPaymentTableViewHeader.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/21.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "OrderPaymentTableViewHeader.h"

@interface OrderPaymentTableViewHeader ()
@property (nonatomic, strong) UIImageView *shopVarietyView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIView *topSpacingView;
@property (nonatomic, strong) UIImageView *shopTypeImageView;
@end
@implementation OrderPaymentTableViewHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        [self updateConstraintsIfNeeded];
        [self setNeedsUpdateConstraints];
        
    }
    return self;
}



- (void)setupViews {
    [self addSubview:self.shopVarietyView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.bottomLineView];
    [self addSubview:self.shopTypeImageView];
    [self addSubview:self.topSpacingView];
}


- (void)setModel:(ShopModel *)model {
    _model = model;
    self.nameLabel.text = model.shopName;
    self.shopVarietyView.backgroundColor = model.shopVariety  > [self imageViewColorArray].count ? [[self imageViewColorArray]lastObject] : [self imageViewColorArray][model.shopVariety - 1];
    self.shopTypeImageView.image = [self shoptype:model.shopTpye];
}


- (NSArray <UIColor *> * )imageViewColorArray {
    return @[[UIColor redColor],
             [UIColor greenColor],
             [UIColor cyanColor]];
    
}



- (UIImage *)shoptype:(NSInteger)type {
    if (type == 1) {/// 合作
        return [UIImage imageNamed:@"icon_cooperation"];
    } else if (type == 2) {
        return [UIImage imageNamed:@"icon_union"];
    } else if (type == 3) {
        return [UIImage imageNamed:@"icon_stock"];
    } else if (type == 5) {
        return [UIImage imageNamed:@"icon_certification"];
    } else {
        return nil;
    }
}

- (UIImageView *)shopVarietyView {
    if (!_shopVarietyView) {
        _shopVarietyView = [[UIImageView alloc]init];
        [_shopVarietyView setBackgroundColor:[UIColor redColor]];
    }
    return _shopVarietyView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
    }
    return _nameLabel;
}



- (UIView *)bottomLineView {
    if (!_bottomLineView ) {
        _bottomLineView = [[UIView alloc]initWithFrame:CGRectZero];
        _bottomLineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1];
    }
    return _bottomLineView;
}

- (UIImageView *)shopTypeImageView {
    if (!_shopTypeImageView) {
        _shopTypeImageView = [[UIImageView alloc]init];
        
    }
    return _shopTypeImageView;
}

- (UIView *)topSpacingView {
    if (!_topSpacingView) {
        _topSpacingView = [[UIView alloc]init];
        _topSpacingView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _topSpacingView;
}

- (void)updateConstraints {
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    [self.topSpacingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(10);
        
    }];
    
    [self.shopVarietyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.centerY.equalTo(self.centerY).offset(5);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopVarietyView.right).offset(10);
        make.centerY.equalTo(self.shopVarietyView);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(0.1);
    }];
    
    [self.shopTypeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.right).offset(10);
        make.centerY.equalTo(self.nameLabel);
        make.size.equalTo(CGSizeMake(30, 15));
    }];
    
    
    
    [super updateConstraints];
}



@end
