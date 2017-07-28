//
//  WaitingEvaluationTableViewHeaderView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/17.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "WaitingEvaluationTableViewHeaderView.h"

@interface WaitingEvaluationTableViewHeaderView ()
@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UIButton *nameButton;
@property (nonatomic, strong) UIButton *evaluationButton;

@end

@implementation WaitingEvaluationTableViewHeaderView



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    
    return self;
    
}

- (void)addSubViews {
    [self.contentView addSubview:self.typeImageView];
    [self.contentView addSubview:self.nameButton];
    [self.contentView addSubview:self.evaluationButton];

}
- (void)updateConstraints {
    
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(24, 24));
    }];
    
    [self.nameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeImageView.right).offset(12);
        make.centerY.equalTo(self.typeImageView);
        make.size.equalTo(CGSizeMake(100, 15));
    }];
    
    [self.evaluationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.centerY.equalTo(self.typeImageView);
        make.size.equalTo(CGSizeMake(60, 25));
    }];
    
    [super updateConstraints];
}

- (void)setShopName:(NSString *)shopName {
    _shopName = shopName;
    [self.nameButton setTitle:shopName forState:UIControlStateNormal];
    [self.nameButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:10.0f];

    [self.nameButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(shopName.length * 15.0 + 20);
    }];
}

- (void)evaluation {
    !self.evaluationBlcok ? : self.evaluationBlcok();
}


- (UIImageView *)typeImageView {
    if (!_typeImageView) {
        _typeImageView = [[UIImageView alloc]init];
        _typeImageView.backgroundColor = [UIColor redColor];
    }
    return _typeImageView;
}

- (UIButton *)nameButton {
    if (!_nameButton) {
        _nameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nameButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
        [_nameButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_nameButton setImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    }
    return _nameButton;
}

- (UIButton *)evaluationButton {
    if (!_evaluationButton) {
        _evaluationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_evaluationButton.layer setBorderWidth:0.2f];
        [_evaluationButton setTitle:@"评价" forState:UIControlStateNormal];
        [_evaluationButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_evaluationButton.layer setBorderColor:[UIColor redColor].CGColor];
        [_evaluationButton.layer setMasksToBounds:YES];
        [_evaluationButton.layer setCornerRadius:5.0f];
        [_evaluationButton addTarget:self action:@selector(evaluation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _evaluationButton;
}



@end
