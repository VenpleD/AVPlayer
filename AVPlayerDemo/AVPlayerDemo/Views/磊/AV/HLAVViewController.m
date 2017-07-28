//
//  HLAVViewController.m
//  AVPlayerDemo
//
//  Created by hlznj on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "HLAVViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AnimationButton.h"

@interface HLAVViewController ()

@end

@implementation HLAVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AnimationButton *button = [[AnimationButton alloc] initWithFrame:CGRectMake(KScreenW/2 - 60, KScreenH - 50, 120, 40)];
    button.backgroundColor = [UIColor purpleColor];
    button.layer.cornerRadius = 8.0;
    [button setTitle:@"点击播放AV" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"并没有AV");
    }];
}

@end
