//
//  BaseViewController.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController



- (instancetype)init{
    self = [super init];
    if (self) {
        self.subjectForClosed       = [RACSubject subject];
        self.replaySubjectForClosed = [RACReplaySubject subject];
    }
    return self;
}

#pragma mark -
#pragma mark --- 下方BottomBar是否隐藏 ----
- (BOOL) hidesBottomBarWhenPushed
{
    return (self.navigationController.topViewController != self);
}

#pragma mark -
#pragma mark --- 状态栏是否隐藏 ---
-(BOOL)prefersStatusBarHidden {
    return NO;
}

#pragma mark -
#pragma mark --- 状态栏样式 ---
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
