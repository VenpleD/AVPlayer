//
//  HotelConfirmInfoView.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 2017/7/25.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "HotelConfirmInfoView.h"


@interface HotelConfirmInfoView ()

@property (nonatomic, strong) UIImageView *topBackgroundImageView;

@property (nonatomic, strong) UIImageView *bottomBackgroundImageView;

@property (nonatomic, strong) NSArray *propertyNameArray;

@property (nonatomic, strong) NSMutableArray *leftLabelArray;

@property (nonatomic, strong) NSArray *leftTitleArray;

@end

@implementation HotelConfirmInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self createBackgroundViews];
    [self createBackgoundSubviews];
    
    return self;
}

- (void)createBackgroundViews {
    
    CGFloat topViewHeight = 176.f;
    CGFloat bottomViewHeight = 44.f;
    CGFloat viewInterval = 10.f;
    CGFloat intervalOne = 12.f;//背景图片距离屏幕边缘的间距
    
    [self setShowsVerticalScrollIndicator:NO];
    [self setContentSize:CGSizeMake(RECT_WIDTH(self), viewInterval * 2 + topViewHeight + bottomViewHeight)];
    
    UIImage *backgroundImage = [UIImage imageNamed:@"background"];
    CGFloat cap = backgroundImage.size.width * 0.5;
    backgroundImage = [backgroundImage resizableImageWithCapInsets:UIEdgeInsetsMake(cap, cap, cap, cap) resizingMode:UIImageResizingModeTile];
    self.topBackgroundImageView = [[UIImageView alloc] init];
    [self.topBackgroundImageView setUserInteractionEnabled:YES];
    [self.topBackgroundImageView setImage:backgroundImage];
    [self.topBackgroundImageView setFrame:CGRectMake(intervalOne, viewInterval, RECT_WIDTH(self) - intervalOne * 2, topViewHeight)];
    [self addSubview:self.topBackgroundImageView];
    
    self.bottomBackgroundImageView = [[UIImageView alloc] init];
    [self.bottomBackgroundImageView setUserInteractionEnabled:YES];
    [self.bottomBackgroundImageView setImage:backgroundImage];
    [self.bottomBackgroundImageView setFrame:CGRectMake(RECT_MIN_X(self.topBackgroundImageView), RECT_MAX_Y(self.topBackgroundImageView) + viewInterval, RECT_WIDTH(self.topBackgroundImageView), bottomViewHeight)];
    [self addSubview:self.bottomBackgroundImageView];
    
}

- (void)createBackgoundSubviews {
    CGFloat shadowLength = 5.f; //图片周围的阴影长度
    CGFloat intervalTwo = 8.f + shadowLength;//分割线距离背景 view 的间距
    CGFloat intervalOfLeftLabel = 19.f + shadowLength;//左边 titleLabel 距离背景 view 的间距
    CGFloat intervalOfRight = 107.f + shadowLength;//右边内容距离背景 view 的间距
    CGFloat lineHeight = 0.5f;
    CGFloat rowHeight = (RECT_HEIGHT(self.topBackgroundImageView) - shadowLength * 2 - 3 * lineHeight) / 4 + lineHeight; //每行视图的行高
    
    NSArray *placeholderArray = @[@"输入真实姓名",
                                  @"用于接收通知"];
    for (NSInteger i = 0; i < self.propertyNameArray.count; i ++) {
        NSString *propertyName = self.propertyNameArray[i];
        id view;
        CGFloat rightViewWidth = RECT_WIDTH(self.topBackgroundImageView) - intervalOfRight - intervalTwo;
        
//        右边按钮和输入框的创建
        if ([propertyName containsString:@"Button"]) {
            view = [YLArrowButton buttonWithType:UIButtonTypeCustom];
            [view setArrangementType:ArrangementTypeBothEnds];
            if ([propertyName isEqualToString:@"arriveTimeButton"]) {
                [view setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
            }
            [view setTitleColor:RGB_HEX(999999) forState:UIControlStateNormal];
            [view setTitle:@"1" forState:UIControlStateNormal];
            [[view valueForKey:@"titleLabel"] setFont:[UIFont systemFontOfSize:14]];
            [self setValue:view forKey:propertyName];
        } else {
            view = [[UITextField alloc] init];
            [view setFont:[UIFont systemFontOfSize:14]];
            [view setTextColor:RGB_HEX(333333)];
            [view setPlaceholder:placeholderArray[i - 1]];
            [self setValue:view forKey:propertyName];
        }
        [view setFrame:CGRectMake(intervalOfRight, rowHeight * i + shadowLength, rightViewWidth, rowHeight)];
        [self.topBackgroundImageView addSubview:[self valueForKey:propertyName]];
        
//        左边title所在label的创建
        UILabel *titleLabel = [[UILabel alloc] init];
        [titleLabel setText:self.leftTitleArray[i]];
        [titleLabel setTextColor:RGB_HEX(666666)];
        [titleLabel setTextAlignment:NSTextAlignmentLeft];
        [titleLabel setFont:[UIFont systemFontOfSize:15]];
        [titleLabel setFrame:CGRectMake(intervalOfLeftLabel, RECT_MIN_Y(((UIView *)view)), intervalOfRight - intervalOfLeftLabel, rowHeight)];
        [self.topBackgroundImageView addSubview:titleLabel];
        
        if (i < self.propertyNameArray.count - 1) {
            UIView *lineView = [[UIView alloc] init];
            [lineView setFrame:CGRectMake(intervalTwo, RECT_MAX_Y(((UIView *)view)), RECT_WIDTH(self.topBackgroundImageView) - intervalTwo * 2, lineHeight)];
            [lineView setBackgroundColor:RGB_HEX(999999)];
            [self.topBackgroundImageView addSubview:lineView];
        } else {
            
//            下面发票相关视图的创建
            UILabel *bottomLeftLabel = [[UILabel alloc] init];
            [bottomLeftLabel setFrame:CGRectMake(intervalOfLeftLabel, shadowLength, intervalOfRight - intervalOfLeftLabel, RECT_HEIGHT(self.bottomBackgroundImageView) - shadowLength * 2)];
            [bottomLeftLabel setTextColor:RGB_HEX(666666)];
            [bottomLeftLabel setTextAlignment:NSTextAlignmentLeft];
            [bottomLeftLabel setFont:[UIFont systemFontOfSize:15]];
            [bottomLeftLabel setText:@"发票"];
            [self.bottomBackgroundImageView addSubview:bottomLeftLabel];
            UILabel *bottomRightLabel = [[UILabel alloc] init];
            [bottomRightLabel setFrame:CGRectMake(intervalOfRight, RECT_MIN_Y(bottomLeftLabel), rightViewWidth, RECT_HEIGHT(bottomLeftLabel))];
            [bottomRightLabel setText:@"请到酒店前台咨询"];
            [bottomRightLabel setTextColor:RGB_HEX(999999)];
            [self.bottomBackgroundImageView addSubview:bottomRightLabel];
        }
    }
}

- (NSArray *)propertyNameArray {
    if (!_propertyNameArray) {
        _propertyNameArray = @[@"roomsButton",
                               @"userNameTextField",
                               @"mobileTextField",
                               @"arriveTimeButton"];
    }
    return _propertyNameArray;
}

- (NSArray *)leftTitleArray {
    if (!_leftTitleArray) {
        _leftTitleArray = @[@"房间数",
                            @"联系人",
                            @"手机号",
                            @"到达时间"];
    }
    return _leftTitleArray;
}

@end
