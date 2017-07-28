//
//  HLBezierViewController.m
//  AVPlayerDemo
//
//  Created by hlznj on 2017/6/29.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "HLBezierViewController.h"
#import "HLBezierView.h"

@interface HLBezierViewController ()

@end

@implementation HLBezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HLBezierView *View = [[HLBezierView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:View];
}

@end
