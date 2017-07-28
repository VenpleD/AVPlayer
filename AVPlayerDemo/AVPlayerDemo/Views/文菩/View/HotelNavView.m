//
//  HotelNavView.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/25.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "HotelNavView.h"

@implementation HotelNavView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self createSubviews];
    
    return self;
}

- (void)createSubviews {
    [self setBackgroundColor:[UIColor clearColor]];
    
    CGFloat viewsHeight = 21.f;
    CGFloat buttonWidth = 13.f;
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(HorizonInterval);
        make.bottom.mas_equalTo(-10.f);
        make.height.mas_equalTo(viewsHeight);
        make.width.mas_equalTo(buttonWidth);
    }];
    
    self.titleLabel = [[UILabel alloc] init];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backButton.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(viewsHeight);
    }];
}


@end
