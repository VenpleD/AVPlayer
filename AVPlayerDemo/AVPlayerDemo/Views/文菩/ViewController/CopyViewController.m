//
//  CopyViewController.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 17/7/24.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "CopyViewController.h"

@interface CopyViewController ()

@property (nonatomic, strong) NSString *nameOne;

@property (nonatomic, strong) NSString *nameTwo;

@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    self.nameOne = @"nameOne";
    self.nameTwo = [self.nameOne mutableCopy];
    printf("nameOne对象地址:%p,指针地址:%p,nameTwo对象地址:%p,指针地址:%p\n",&*_nameOne,&_nameOne,&*_nameTwo,&_nameTwo);
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
