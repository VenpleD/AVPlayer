//
//  PhotoView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/14.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PhotoView.h"
@interface PhotoView ()
@property (nonatomic, strong) UIImageView *photoImageView;
@end
@implementation PhotoView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}



- (void)addSubViews {
 
    [self addSubview: self.photoImageView];
    [self addSubview:self.photoDeleteButton];
}

- (void)updateConstraints {
    
    [self.photoImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(0);
        make.size.equalTo(CGSizeMake(75, 75));
    }];
    
    
    [self.photoDeleteButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.photoImageView.right);
        make.centerY.equalTo(self.photoImageView.top);
        make.size.equalTo(CGSizeMake(40, 40));
    }];
    [super updateConstraints];
    
}

- (void)setTag:(NSInteger)tag {
    [super setTag:tag];
     [self.photoDeleteButton setTag:self.tag];
}


- (void)setPhotoImage:(UIImage *)photoImage {
    self.photoImageView.image = photoImage;
}

- (UIButton *)photoDeleteButton {
    if (!_photoDeleteButton) {
        _photoDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoDeleteButton setImage:[UIImage imageNamed:@"icon_del"] forState:UIControlStateNormal];
       

    }
    return _photoDeleteButton;
}


- (UIImageView *)photoImageView {
    if (!_photoImageView) {
        _photoImageView = [[UIImageView alloc]init];
        
    }
    return _photoImageView;
}

@end
