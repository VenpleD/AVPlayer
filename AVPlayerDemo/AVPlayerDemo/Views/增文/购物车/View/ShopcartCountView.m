//
//  ShopcartCountView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/10.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "ShopcartCountView.h"
#import "UIButton+ImageTitleSpacing.h"
@interface ShopcartCountView ()

/**
 编辑状态的视图
 */
@property (nonatomic, strong) UIView *didEditView;

/**
 减号
 */
@property (nonatomic, strong) UIButton *minusButton;

/**
 加号
 */
@property (nonatomic, strong) UIButton *addButton;

/**
 商品数量
 */
@property (nonatomic, strong) UILabel *goodsQtyLabel;

/**
 数量计数
 */
@property (nonatomic, assign) NSInteger goodsQty;


/**
 商品尺寸规格
 */
@property (nonatomic, strong) UIButton *goodsSpecificationsButton;



@end

@implementation ShopcartCountView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubView];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)configureShopcartCountViewWithProductCount:(NSInteger)count productStock:(NSInteger)stock goodsSpecifications:(NSString *)goodsSpecifications {
    self.goodsQty = count;
    self.goodsQtyLabel.text = [NSString stringWithFormat:@"%ld",count];
    self.minusButton.enabled = count <= 1 ? NO : YES;
    self.minusButton.alpha   = count <= 1 ? 0.4 : 1;
    if (stock) {
        
        self.addButton.enabled = count >= stock ? NO : YES;
        self.addButton.alpha   = count >= stock ? 0.4 : 1;

    } else {
        self.addButton.enabled = count >= 99 ? NO : YES;
        self.addButton.alpha   = count >= 99 ? 0.4 : 1;
    }
    [self.goodsSpecificationsButton setTitle:goodsSpecifications forState:UIControlStateNormal];
    [self.goodsSpecificationsButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5.0];

}

- (void)addQty {
    self.goodsQty ++;
    !self.shopcartCountViewEditBlock ? :self.shopcartCountViewEditBlock(self.goodsQty);
}

- (void)minusQty {
    self.goodsQty --;
    !self.shopcartCountViewEditBlock ? :self.shopcartCountViewEditBlock(self.goodsQty);
}


- (void)setSubView {
    [self addSubview:self.addButton];
    [self addSubview:self.minusButton];
    [self addSubview:self.goodsQtyLabel];
    [self addSubview:self.goodsSpecificationsButton];
}

- (void)updateConstraints {
  
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.top.equalTo(20);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    
    [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.addButton.left).offset(-100);
        make.top.width.height.equalTo(self.addButton);
    }];
    
    
    [self.goodsQtyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.addButton);
        make.left.equalTo(self.minusButton.right);
        make.right.equalTo(self.addButton.left);
    }];
    
    [self.goodsSpecificationsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(-13);
        make.right.equalTo(-15);
        make.size.equalTo(CGSizeMake(150, 12));
    }];
    
    [super updateConstraints];
}

- (UIView *)didEditView {
    if (!_didEditView) {
        _didEditView = [[UIView alloc]initWithFrame:CGRectZero];
        [_didEditView setBackgroundColor:[UIColor redColor]];
    }
    return _didEditView;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(addQty) forControlEvents:UIControlEventTouchUpInside];

    }
    return _addButton;
}

- (UIButton *)minusButton {
    if (!_minusButton) {
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusButton setImage:[UIImage imageNamed:@"icon_minus"] forState:UIControlStateNormal];
        [_minusButton addTarget:self action:@selector(minusQty) forControlEvents:UIControlEventTouchUpInside];

    }
    return _minusButton;
}

- (UILabel *)goodsQtyLabel {
    if (!_goodsQtyLabel) {
        _goodsQtyLabel = [[UILabel alloc]init];
        [_goodsQtyLabel setFont:[UIFont systemFontOfSize:12]];
        [_goodsQtyLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _goodsQtyLabel;
}

- (UIButton *)goodsSpecificationsButton {
    if (!_goodsSpecificationsButton) {
        _goodsSpecificationsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_goodsSpecificationsButton setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
        [_goodsSpecificationsButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_goodsSpecificationsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_goodsSpecificationsButton.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    }
    return _goodsSpecificationsButton;
}

@end
