//
//  PhotoImageView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/13.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PhotoImageView.h"
@interface PhotoImageView ()
@property (nonatomic, strong) UIButton *deleteButton;
@end



@implementation PhotoImageView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        [self addSubview:self.deleteButton];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints {
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.right);
        make.centerY.equalTo(self.top);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    [super updateConstraints];
}


- (void)delete {
    [self removeFromSuperview];
    !self.deleteBlock ? : self.deleteBlock();
}

-(UIButton *)deleteButton {//haole，所有的图片公用一个删除按钮？nakebu yige那这做起来肯定有问题啊而且需要判断的东西很多na za zuo ,nishuo 这个图片的iamgeview要和button对应起来，他怎么创建的，按钮就怎么创建
    // ni yi si zai wai mian ye yong  for chuangjian an niu  ?你这个页面页面着急做不,wo xie de shi 18 hao wan cheng ，我明天过去帮你写，帮你屡屡这种东西的逻辑怎么去写
//    你的逻辑有问题，我一直感觉 你先做其他的，因为我现在跟你说，你这些东西肯定是不能要的你看着
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}


@end
