//
//  CartTableViewHeaderView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/7.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "CartTableViewHeaderView.h"
@interface CartTableViewHeaderView()
@property (nonatomic, strong) UIImageView *shopVarietyView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *shopSelectButton;
@property (nonatomic, strong) UIView *bottomLineView;
@property (nonatomic, strong) UIImageView *shopTypeImageView;
@end
@implementation CartTableViewHeaderView

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
    [self addSubview:self.shopSelectButton];
    [self addSubview:self.bottomLineView];
    [self addSubview:self.shopTypeImageView];
}

- (void)configureShopcartHeaderViewWithshopName:(NSString *)shopName
                                    shopVariety:(NSInteger)shopVariety
                                       shopType:(NSInteger)type
                                     shopSelect:(BOOL)shopSelect {
    self.shopSelectButton.selected = shopSelect;
    self.nameLabel.text = shopName;
    self.shopVarietyView.backgroundColor = shopVariety  > [self imageViewColorArray].count ? [[self imageViewColorArray]lastObject] : [self imageViewColorArray][shopVariety - 1];
    self.shopTypeImageView.image = [self shoptype:type];
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

- (UIButton *)shopSelectButton {
    if (!_shopSelectButton) {
        _shopSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shopSelectButton setImage:[UIImage imageNamed:@"未选中按钮-01"] forState:UIControlStateNormal];
        [_shopSelectButton setImage:[UIImage imageNamed:@"单选按钮-选中"] forState:UIControlStateSelected];
    [_shopSelectButton bk_addEventHandler:^(UIButton *sender) {
        sender.selected = !sender.selected;
        !self.shopcartHeaderViewBlock ? : self.shopcartHeaderViewBlock(sender.selected);
        
    } forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopSelectButton;
    
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


- (void)updateConstraints {
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
    [self.shopSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    
    [self.shopVarietyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopSelectButton.right).offset(10);
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(20, 20));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopVarietyView.right).offset(10);
        make.centerY.equalTo(self);
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
