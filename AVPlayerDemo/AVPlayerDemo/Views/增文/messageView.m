//
//  massageView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/19.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "messageView.h"
@interface messageView ()
@property (nonatomic, strong) UIButton *messageButton;
@property (nonatomic, strong) UILabel *messageLabel;



@end
@implementation messageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.messageButton];
        [self addSubview:self.messageLabel];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)updateConstraints {
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(0);
        make.top.equalTo(10);
        make.right.equalTo(-10);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(0);
    }];
    [super updateConstraints];
}

- (void)setMessageImage:(UIImage *)messageImage {
    _messageImage = messageImage;
    [self.messageButton setImage:messageImage forState:UIControlStateNormal];
}

- (void)setMessageNumerString:(NSString *)messageNumerString {
    _messageNumerString = messageNumerString;
    if ([messageNumerString integerValue] > 99) {
        messageNumerString = @"99+";
    }
    self.messageLabel.text = messageNumerString;
}

- (void)messsage {
    !self.clickButton ? : self.clickButton();
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.backgroundColor = [UIColor redColor];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.font = [UIFont systemFontOfSize:10.0f];
        _messageLabel.layer.masksToBounds = YES;
        _messageLabel.layer.cornerRadius  = 5.0f;
    }
    return _messageLabel;
}

- (UIButton *)messageButton {
    if (!_messageButton) {
        _messageButton = [[UIButton alloc]init];
        [_messageButton addTarget:self action:@selector(messsage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageButton;
}



@end
