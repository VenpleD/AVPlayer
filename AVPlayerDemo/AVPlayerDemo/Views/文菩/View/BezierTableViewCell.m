//
//  BezierTableViewCell.m
//  BezierAnimation
//
//  Created by duanwenpu on 17/7/4.
//  Copyright © 2017年 duanwenpu. All rights reserved.
//

#import "BezierTableViewCell.h"

@implementation BezierTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) return nil;
    self.bezierButton = [BezierButton buttonWithType:UIButtonTypeCustom];
    CGFloat buttonLength = 30.f;
    [self.bezierButton setFrame:CGRectMake(self.contentView.frame.size.width - 50, 0, buttonLength, buttonLength)];
    [self.bezierButton setBackgroundColor:[UIColor blueColor]];
    [self.contentView addSubview:self.bezierButton];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
