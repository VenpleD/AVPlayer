//
//  ShoppingCartView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/6/23.
//  Copyright © 2017年 周伟. All rights reserved.
//





#import "ZW_ShoppingCartView.h"
#import "CartImageView.h"


// 购物车的宽度
#define KcartWidth  KScreenW / 6.0

@interface ZW_ShoppingCartView()
@property (nonatomic, assign) NSInteger ids;
@property (nonatomic, strong) UILabel *numerLabel;

@property (nonatomic, strong) UIView  *maskView;
@property (nonatomic, strong) UIView  *backgroundView;

//@property (nonatomic, strong) <#id#> *<#name#>;
@property (nonatomic, strong) UIButton *settleAccountsButton;
;


@end



@implementation ZW_ShoppingCartView

- (UIImageView *)cartImageView {
    if(!_cartImageView ){
        _cartImageView                     = [[UIImageView alloc]init];
//        _cartImageView.layer.masksToBounds = YES;
//        _cartImageView.layer.cornerRadius  =  KcartWidth / 2 ;
        _cartImageView.image               = [UIImage imageNamed:@"购物车"];
        _cartImageView.contentMode         = UIViewContentModeScaleAspectFill;
    }
    return _cartImageView;
}

- (UILabel *)numerLabel {
    if (!_numerLabel) {
        _numerLabel                     = [[UILabel alloc]init];
        _numerLabel.backgroundColor     = [UIColor redColor];
        _numerLabel.textColor           = [UIColor whiteColor];
        _numerLabel.layer.masksToBounds = YES;
        _numerLabel.layer.cornerRadius  =  3;
        _numerLabel.textAlignment       = NSTextAlignmentCenter;
        _numerLabel.font                = [UIFont systemFontOfSize:11.5];
        _numerLabel.hidden              = YES;
    }
    return _numerLabel;
}

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 60 - 64)];
        _backgroundView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    }
    return _backgroundView;
}


- (UIButton *)settleAccountsButton {
    if (!_settleAccountsButton) {
        _settleAccountsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settleAccountsButton setTitle:@"结算" forState:UIControlStateNormal];
        [_settleAccountsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _settleAccountsButton.backgroundColor = [UIColor yellowColor];
        @weakify(self);
        [_settleAccountsButton bk_addEventHandler:^(id sender) {
            @strongify(self);
            !self.zw_Account ? :self.zw_Account();
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _settleAccountsButton;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.backgroundView removeFromSuperview];
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    
        
        self.backgroundColor = [UIColor cyanColor];
        [self addSubview:self.cartImageView];
        [self.cartImageView addSubview:self.numerLabel];
        [self addSubview:self.settleAccountsButton];
        [self setNeedsUpdateConstraints];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(popView:)];
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)popView:(UIGestureRecognizer *)tap {
    NSLog(@"------%@",tap);
//    [[UIApplication sharedApplication].keyWindow addSubview:self.backgroundView];
    
    
    
    
    
}


-(void)updateConstraints {
    [super updateConstraints];
    
    [self.cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.top.equalTo(- KcartWidth/3);
        make.size.equalTo(CGSizeMake(KcartWidth, KcartWidth));

    }];
    
    [self.numerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cartImageView.right).offset(-10);
        make.top.equalTo(10);
        make.size.equalTo(CGSizeMake(11, 11));
    }];
    
    [self.settleAccountsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(0);
        make.width.equalTo(100);
        
    }];
    
    
    
    
    NSLog(@"---%f",        self.cartImageView.frame.size.width);

}


- (void)showView {
    
    POPSpringAnimation *shake = [POPSpringAnimation animationWithPropertyNamed:kPOPViewBounds];
    shake.springBounciness    = 20;
    shake.springSpeed         = 20;
    shake.fromValue           = [NSValue valueWithCGRect:CGRectMake(0, 0, KcartWidth+ 5, KcartWidth+ 5)];
    shake.toValue             = [NSValue valueWithCGRect:CGRectMake(0, 0, KcartWidth , KcartWidth)];
    [self.cartImageView pop_addAnimation:shake forKey:nil];
    _ids ++;
    
    self.numerLabel.text = [NSString stringWithFormat:@"%ld",_ids];
    self.numerLabel.hidden = NO;
    [self.numerLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.numerLabel.text.length * 11);
    }];
    
    
    NSLog(@"___%ld",_ids);
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
