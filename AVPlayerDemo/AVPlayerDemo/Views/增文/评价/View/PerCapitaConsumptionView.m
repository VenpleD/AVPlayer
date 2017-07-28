//
//  PerCapitaConsumptionView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/12.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PerCapitaConsumptionView.h"

@interface PerCapitaConsumptionView () <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UITextField *numerTextField;
@property (nonatomic, assign) BOOL isHaveDian;
@end


@implementation PerCapitaConsumptionView


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
    [self addSubview:self.titleLabel];
    [self addSubview:self.currencyLabel];
    [self addSubview:self.numerTextField];
}

- (void)updateConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self);
    }];
    
    [self.currencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.right).offset(15);
        make.centerY.equalTo(self);
    }];
    
    [self.numerTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currencyLabel.right).offset(10);
        make.centerY.equalTo(self);
        make.right.equalTo(self.right).offset(-15);
        make.height.equalTo(self.titleLabel);
    }];
    //设置label1的content hugging 为1000
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置label1的content compression 为1000
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置右边的label2的content hugging 为1000
    [self.currencyLabel setContentHuggingPriority:UILayoutPriorityRequired
                               forAxis:UILayoutConstraintAxisHorizontal];
    
    //设置右边的label2的content compression 为250
    [self.currencyLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                             forAxis:UILayoutConstraintAxisHorizontal];
    [super updateConstraints];
}

#pragma mark --
#pragma mark ---UITextFiled Delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([self.numerTextField.text rangeOfString:@"."].location==NSNotFound) {
        _isHaveDian = NO;
    } if ([string length]>0) {
        if ([self.numerTextField.text length]>7) {
            
            return NO;
        }
        
        unichar single=[string characterAtIndex:0];//当前输入的字符
        //数据格式正确
        if ((single >='0' && single<='9') || single=='.') {
            
            
            if (single=='.') {
                //text中还没有小数点
                if(!_isHaveDian) {
                    _isHaveDian=YES;
                    return YES;
                } else {
                    [self.numerTextField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                
            } else {
                //存在小数点
                if (_isHaveDian) {
                    //判断小数点的位数
                    NSRange ran=[self.numerTextField.text rangeOfString:@"."];
                    
                    NSInteger tt = range.location-ran.location;
                    
                    if (tt <= 2) {
                        return YES;
                    } else {
                        
                        return NO;
                    }
                } else {
                    return YES;
                    
                }
                
                
            }
        } else {//输入的数据格式不正确
            
            [self.numerTextField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
            
        }
        
    }
    
    else
    {
        return YES;
        
    }
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setFont:[UIFont systemFontOfSize:17.0]];
        [_titleLabel setText:@"人均消费"];
        
    }
    return _titleLabel;
}


- (UILabel *)currencyLabel {
    if (!_currencyLabel) {
        _currencyLabel = [[UILabel alloc]init];
        [_currencyLabel setFont:[UIFont systemFontOfSize:17.0]];
        [_currencyLabel setText:@"￥"];
        [_currencyLabel setTextColor:[UIColor redColor]];
    }
    return _currencyLabel;
}

- (UITextField *)numerTextField {
    if (!_numerTextField) {
        _numerTextField = [[UITextField alloc]init];
        [_numerTextField setPlaceholder:@"请输入消费金额"];
        [_numerTextField setKeyboardType:UIKeyboardTypeDecimalPad];
        [_numerTextField setDelegate:self];
        [_numerTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        
    }
    return _numerTextField;
}


@end
