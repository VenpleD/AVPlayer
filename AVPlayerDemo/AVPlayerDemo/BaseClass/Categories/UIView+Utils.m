//
//  UIView+Utils.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/22.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

@end
