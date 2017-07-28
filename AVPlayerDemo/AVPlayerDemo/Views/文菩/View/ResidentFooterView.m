//
//  ResidentFooterView.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/26.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "ResidentFooterView.h"

@implementation ResidentFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self createSubiews];
    
    return self;
}

- (void)createSubiews {
    
    [self setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat buttonWidth = 120.f; //提交按钮的宽度
    CGFloat leftMargin = 15.f; //距离左边的边距
    
    CGRect labelRect = CGRectMake(leftMargin, 0, CGRectGetWidth(self.frame) - buttonWidth - leftMargin, CGRectGetHeight(self.frame));
    self.totalPriceLabel = [[UILabel alloc] init];
    [self.totalPriceLabel setFrame:labelRect];
    [self.totalPriceLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.totalPriceLabel];
    
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitButton setFrame:CGRectMake(CGRectGetMaxX(labelRect), 0, buttonWidth, CGRectGetHeight(labelRect))];
    [self.submitButton setTitle:@"提交订单" forState:UIControlStateNormal];
    [self.submitButton setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.submitButton];

}

@end
