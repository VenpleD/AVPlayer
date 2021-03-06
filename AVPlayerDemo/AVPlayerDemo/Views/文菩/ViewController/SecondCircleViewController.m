//
//  SecondCircleViewController.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 17/7/20.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "SecondCircleViewController.h"
#import "BlockSingle.h"

@interface SecondCircleViewController ()

@end

@implementation SecondCircleViewController

- (void)dealloc {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blueColor]];
    [[BlockSingle shareBlock] sendBlock:^{
        [self alertAction];
    } withControllerName:NSStringFromClass([self class])];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)alertAction {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"title" message:@"SecondCircleViewController" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
    [alertView show];
    [BlockSingle shareBlock].circleBlock = nil;
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
