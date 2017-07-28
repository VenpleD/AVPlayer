//
//  PayResultHeaderView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/24.
//  Copyright © 2017年 Five gods. All rights reserved.
//

typedef void(^CodeViewImageWidthBlock)(CGFloat width);
@interface showCodeBgView : UIView
@property (nonatomic, copy) CodeViewImageWidthBlock viewWidth;


+ (instancetype)codeView;

/// 显示二维码大图
- (void)codeViewShowImage:(UIImage *)image;
/// 消失
- (void)codeViewHidden;

@end

@interface showCodeBgView ()
@property (nonatomic, strong) UIImageView *codeImageView;
@end
@implementation showCodeBgView

+ (instancetype)codeView {
    return [[showCodeBgView alloc]initWithFrame:[UIScreen mainScreen].bounds];
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor clearColor]colorWithAlphaComponent:0.3];
        
        [self addSubview:self.codeImageView];
        [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.left.equalTo(60);
            make.right.equalTo(-60);
            make.height.equalTo(self.codeImageView.width);
        }];
        
        
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self codeViewHidden];
}


- (void)codeViewShowImage:(UIImage *)image {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.codeImageView.image = image;
}

- (void)codeViewHidden {
    self.codeImageView.bounds = CGRectMake(0, 0, 0, 0);
    [self removeFromSuperview];
}


- (UIImageView *)codeImageView {
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc]init];
    }
    return _codeImageView;
}


@end






#import "PayResultHeaderView.h"

@interface PayResultHeaderView ()
@property (nonatomic, strong) UIView *succeedBgView;
@property (nonatomic, strong) UIImageView *succeedImageView;
@property (nonatomic, strong) UILabel *succeedLabel;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIView *leftBgView;
@property (nonatomic, strong) UILabel * consumptionCodeLabel;
@property (nonatomic, strong) UILabel *alertLabel;

@property (nonatomic, strong) UIView *rightBgView;
@property (nonatomic, strong) UIButton *consumptionCodeButton;

@end

@implementation PayResultHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}


- (void)showCode {
    
    [[showCodeBgView codeView]codeViewShowImage:[self createNonInterpolatedUIImageFormCIImage:[self outputImageStr:@"35042456263"] withSize:kSCREEN_WIDTH - 120]];
}





- (void)addSubviews {
    [self addSubview:self.succeedBgView];
    [self.succeedBgView addSubview:self.succeedLabel];
    [self.succeedBgView addSubview:self.succeedImageView];
    
    [self addSubview:self.bgImageView];
    
    [self.bgImageView addSubview:self.leftBgView];
    [self.leftBgView addSubview:self.consumptionCodeLabel];
    [self.leftBgView addSubview:self.alertLabel];
    
    [self.bgImageView addSubview:self.rightBgView];
    [self.rightBgView addSubview:self.consumptionCodeButton];
    
}

- (void)updateConstraints {
    [self.succeedBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(30);
        make.size.equalTo(CGSizeMake(140, 32));
        
    }];
    
    [self.succeedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(0);
        make.width.equalTo(self.succeedImageView.height);
        
    }];
    
    [self.succeedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.succeedImageView.right).offset(15);
        make.centerY.equalTo(self.succeedImageView);
    }];
    
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.right.equalTo(-15);
        make.height.equalTo(105);
        make.top.equalTo(self.succeedBgView.bottom).offset(30);
        
    }];
    
    [self.leftBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(20);
        make.right.equalTo(self.rightBgView.left).offset(-10);
        make.top.equalTo(10);
        make.bottom.equalTo(-10);
    }];
    
    [self.consumptionCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(10);
        make.right.equalTo(-10);
        make.top.equalTo(20.f / 667.f * kSCREEN_HEIGHT);
        
    }];
    
    [self.alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.consumptionCodeLabel);
        make.top.equalTo(self.consumptionCodeLabel.bottom).offset(10);
    }];
    
    [self.rightBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(0);
        make.left.equalTo(self.leftBgView.right).offset(10);
        make.top.equalTo(10);
        make.bottom.equalTo(-10);
    }];
    
    [self.consumptionCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rightBgView);
        make.right.equalTo(-15);
        make.left.equalTo(15);
        make.height.equalTo(self.consumptionCodeButton.width);
    }];
    
    [super updateConstraints];
}

#pragma mark --- 分割字符串
- (NSString *)separatedDigitStringWithStr:(NSString *)str {
    NSMutableString *mutableStr = [[NSMutableString alloc]initWithFormat:@"%@",str];
    for (NSInteger i = 0; i < str.length / 4 -1; i ++) {
        [mutableStr insertString:@" " atIndex:4 + ( 4 * i) + i];
    }
    return mutableStr;
}



- (CIImage *)outputImageStr:(NSString *)str {
    // 1.创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认
    [filter setDefaults];
    // 3.给过滤器添加数据(正则表达式/账号和密码)
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    return  [filter outputImage];
 
}


#pragma mark --- 根据CIImage生成指定大小的UIImage
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
     // 1.创建bitmap;
     size_t width = CGRectGetWidth(extent) * scale;
     size_t height = CGRectGetHeight(extent) * scale;
     CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
     CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone); CIContext *context = [CIContext contextWithOptions:nil];
     CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
     CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
     CGContextScaleCTM(bitmapRef, scale, scale);
     CGContextDrawImage(bitmapRef, extent, bitmapImage);
     // 2.保存bitmap到图片
     CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
     CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);
     return [UIImage imageWithCGImage:scaledImage];
 }
     
  
- (UIImageView *)succeedImageView {
    if (!_succeedImageView) {
        _succeedImageView = [[UIImageView alloc]init];
        _succeedImageView.image = [UIImage imageNamed:@"modified_succeed"];
        
    }
    return _succeedImageView;
}


- (UILabel *)succeedLabel {
    if (!_succeedLabel) {
        _succeedLabel = [[UILabel alloc]init];
        _succeedLabel.font = [UIFont systemFontOfSize:20.f];
        _succeedLabel.text = @"购买成功!";
    }
    return _succeedLabel;
}


- (UIView *)succeedBgView {
    if (!_succeedBgView) {
        _succeedBgView = [[UIView alloc]init];
        _succeedBgView.backgroundColor = self.backgroundColor;
    }
    return _succeedBgView;
}

-(UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        _bgImageView.image = [UIImage imageNamed:@"img_code"];
        _bgImageView.userInteractionEnabled = YES;
    }
    return _bgImageView;
}

- (UILabel *)consumptionCodeLabel {
    if (!_consumptionCodeLabel) {
        _consumptionCodeLabel = [[UILabel alloc]init];
        _consumptionCodeLabel.textColor = [UIColor redColor];
        _consumptionCodeLabel.text = [self separatedDigitStringWithStr:@"350424562636"];
        _consumptionCodeLabel.textAlignment = NSTextAlignmentCenter;
        [_consumptionCodeLabel.text substringToIndex:1];
        _consumptionCodeLabel.adjustsFontSizeToFitWidth = YES;
        _consumptionCodeLabel.font = [UIFont systemFontOfSize:24.f];
    }
    return _consumptionCodeLabel;
}

- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc]init];
        _alertLabel.font = [UIFont systemFontOfSize:12.f];
        _alertLabel.text = @"商家扫描消费码即可消费";
    }
    return _alertLabel;
}

- (UIButton *)consumptionCodeButton {
    if (!_consumptionCodeButton) {
        _consumptionCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_consumptionCodeButton setImage:[self createNonInterpolatedUIImageFormCIImage:[self outputImageStr:@"35042456263"] withSize:62.5] forState:UIControlStateNormal];
        [_consumptionCodeButton addTarget:self action:@selector(showCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _consumptionCodeButton;
}

- (UIView *)leftBgView {
    if (!_leftBgView) {
        _leftBgView = [[UIView alloc]init];
//        _leftBgView.backgroundColor = [UIColor greenColor];
    }
    return _leftBgView;
}

- (UIView *)rightBgView {
    if (!_rightBgView) {
        _rightBgView = [[UIView alloc]init];
//        _rightBgView.backgroundColor = [UIColor orangeColor];
    }
    return _rightBgView;
}


@end
