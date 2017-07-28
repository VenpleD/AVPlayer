//
//  VCTimer.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/22.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "VCTimer.h"

@interface VCTimer ()

@property (nonatomic, strong) UIButton *clickBtn;

@end

@implementation VCTimer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.clickBtn = btn;
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn setCornerRadius:50];
    [self.view addSubview:btn];
    
    //layout
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(CGSizeMake(200, 100));
    }];
    
    //action
    @weakify(self)
    [btn bk_whenTapped:^{
        @strongify(self)
        [self timeAnimation];
    }];
}

#pragma mark ---
#pragma mark ---- Animation ---
- (void)timeAnimation{
    
    POPBasicAnimation *basicAnimation = [POPBasicAnimation linearAnimation];
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"timeAnimation" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat *values) {
            UIButton *btn = (UIButton *)obj;
            [btn setTitle:[NSString stringWithFormat:@"剩余(%d)s",(int)values[0]%60] forState:UIControlStateNormal];
        };
        
    }];
    
    basicAnimation.property = prop;
    basicAnimation.fromValue = @(10);
    basicAnimation.toValue = @(1);
    basicAnimation.duration = 9;
    
    [self.clickBtn pop_addAnimation:basicAnimation forKey:@"timeAnimation"];
    
    //开始
    basicAnimation.animationDidStartBlock = ^(POPAnimation *anim) {
        self.clickBtn.enabled = NO;
    };
    
    //结束
    basicAnimation.completionBlock = ^(POPAnimation *anim, BOOL finished) {
        self.clickBtn.enabled = YES;
        [self.clickBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
