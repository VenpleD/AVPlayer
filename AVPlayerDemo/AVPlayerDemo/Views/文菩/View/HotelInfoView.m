//
//  HotelInfoView.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/25.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "HotelInfoView.h"

@interface HotelInfoView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;

@property (nonatomic, strong) NSArray *propertyNameArray;

@end

@implementation HotelInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self createBackgroundViews];
    [self createBackgoundSubviews];
    
    return self;
}

- (void)createBackgroundViews {
    self.backgroundColor = [UIColor clearColor];
    UIImage *backgroundImage = [UIImage imageNamed:@"hotel_info"];
    CGFloat leftCap = backgroundImage.size.width * 0.5;
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, leftCap, 0, leftCap) resizingMode:UIImageResizingModeTile];
    self.backgroundImageView = [[UIImageView alloc] init];
    [self.backgroundImageView setImage:backgroundImage];
    [self.backgroundImageView setFrame:CGRectMake(0, 0, RECT_WIDTH(self), RECT_HEIGHT(self))];
    [self addSubview:self.backgroundImageView];
}

- (void)createBackgoundSubviews {
    CGFloat shadowLength = 4.f; //图片周围的阴影长度
    CGFloat horizonInterval = 18.f + shadowLength; //水平方向距离左右边缘的间距
    CGFloat typeLabelHeight = 44.f;
    self.roomsTypeLabel = [[UILabel alloc] init];
    [self.roomsTypeLabel setText:@"单人标准房"];
    [self.roomsTypeLabel setFont:[UIFont systemFontOfSize:16]];
    [self.roomsTypeLabel setTextColor:RGB_HEX(333333)];
    [self.backgroundImageView addSubview:self.roomsTypeLabel];
    [self.roomsTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(horizonInterval);
        make.right.mas_equalTo(-horizonInterval);
        make.height.mas_equalTo(typeLabelHeight);
        make.top.mas_equalTo(shadowLength);
    }];
    
    CGFloat intervalOfLine = 10.f; //虚线距离边缘的间距
    CGFloat lineHeight = 0.5f;
    UIView *lineView = [[UIView alloc] init];
    [lineView setFrame:CGRectMake(intervalOfLine, shadowLength + typeLabelHeight, RECT_WIDTH(self) - intervalOfLine * 2, lineHeight)];
    [self drawDashLine:lineView lineLength:lineHeight lineSpacing:3 lineColor:[UIColor blackColor]];
    [self.backgroundImageView addSubview:lineView];
    
    CGFloat otherLabelHeight = (RECT_HEIGHT(self) - typeLabelHeight - shadowLength * 2 - lineHeight) / 3; //其他三个label是虚线下面的高度除以三得到的
    for (NSInteger i = 0; i < self.propertyNameArray.count; i ++) {
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:RGB_HEX(333333)];
        [label setFont:[UIFont systemFontOfSize:12]];
        [label setAdjustsFontSizeToFitWidth:YES];
        [label setFrame:CGRectMake(horizonInterval, RECT_MAX_Y(lineView) + otherLabelHeight * i, RECT_WIDTH(self) - horizonInterval * 2, otherLabelHeight)];
        [self addSubview:label];
        [self setValue:label forKey:self.propertyNameArray[i]];
    }
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView
          lineLength:(int)lineLength
         lineSpacing:(int)lineSpacing
           lineColor:(UIColor *)lineColor {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
    
}

- (NSArray *)propertyNameArray {
    if (!_propertyNameArray) {
        _propertyNameArray = @[@"timesLabel",
                               @"roomsEnvironmentLabel",
                               @"cancelTimeLabel"];
    }
    return _propertyNameArray;
}

@end
