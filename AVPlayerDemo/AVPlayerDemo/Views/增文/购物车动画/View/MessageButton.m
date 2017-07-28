//
//  MessageButton.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/3.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "MessageButton.h"

@interface MessageButton()
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation MessageButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
   
        [self addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(5);
            make.top.equalTo(-5);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        
    }
    return self;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.textColor = [UIColor whiteColor];
        _messageLabel.backgroundColor = [UIColor redColor];
        _messageLabel.numberOfLines = 1;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:8.0f];
        _messageLabel.layer.masksToBounds = YES;
        _messageLabel.layer.cornerRadius = 10;
    }
    return _messageLabel;
}

- (void)setNumerString:(NSString *)numerString {
    static NSInteger numerIntrger;
    numerIntrger = [numerString integerValue];
    if (numerIntrger >= 100) {
        numerString = @"99+";
    }
    self.messageLabel.text = numerString;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
