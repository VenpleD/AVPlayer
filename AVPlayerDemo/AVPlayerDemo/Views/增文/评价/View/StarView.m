//
//  StarView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/12.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "StarView.h"
#import "TPFloatRatingView.h"
@interface StarView ()<TPFloatRatingViewDelegate>
@property (nonatomic, strong) TPFloatRatingView *controlStrView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *gradeLabel;
@end

@implementation StarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = 3.0f;
        [self setSubView];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)setSubView {
    [self addSubview:self.controlStrView];
    [self addSubview:self.typeLabel];
    [self addSubview:self.gradeLabel];
}

- (void)updateConstraints {
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.centerY.equalTo(self);
        make.width.equalTo(70);
    }];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(0);
        make.width.height.top.equalTo(self.typeLabel);
    }];
    [self.controlStrView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.right).offset(38);
        make.right.equalTo(self.gradeLabel.left).offset(-38);
        make.centerY.equalTo(self.typeLabel);
        make.height.equalTo(30);
    }];

    [super updateConstraints];
}

- (void)typeTitle:(NSString *)title rating:(CGFloat)rating {
    [self.typeLabel setText:title];
    [self.controlStrView setRating:rating];
    [self transformationStar:rating];
}


- (TPFloatRatingView *)controlStrView {
    if (!_controlStrView) {
        _controlStrView = [[TPFloatRatingView alloc]initWithFrame:CGRectZero];
        _controlStrView.emptySelectedImage = [UIImage imageNamed:@"icon_score_big_g"];
        _controlStrView.fullSelectedImage = [UIImage imageNamed:@"icon_score_big"];
        _controlStrView.delegate = self;
        _controlStrView.maxRating = 5;
        _controlStrView.minRating = 1;
        _controlStrView.rating = 0;
        _controlStrView.editable = YES;
        _controlStrView.halfRatings = YES;
        _controlStrView.floatRatings = NO;
        _controlStrView.minImageSize = CGSizeMake(10, 10);
    }
    return _controlStrView;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        [_typeLabel setFont:[UIFont systemFontOfSize:17.0]];
        [_typeLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _typeLabel;
}

- (UILabel *)gradeLabel {
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc]init];
        [_gradeLabel setFont:[UIFont systemFontOfSize:17.0]];
        [_gradeLabel setTextColor:[UIColor lightGrayColor]];
        [_gradeLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _gradeLabel;
}

- (void)floatRatingView:(TPFloatRatingView *)ratingView ratingDidChange:(CGFloat)rating {
    [self transformationStar:rating];
    !self.starBlock ? : self.starBlock(rating);
}


- (void)floatRatingView:(TPFloatRatingView *)ratingView continuousRating:(CGFloat)rating {

}

- (void)transformationStar:(CGFloat)rating {
    if (rating <= 3 ) {
        self.gradeLabel.text = @"一般";
    }  else if (rating > 3 && rating <= 4.5) {
        self.gradeLabel.text = @"好";
    } else  {
    self.gradeLabel.text = @"非常好";
    }
    
}

@end
