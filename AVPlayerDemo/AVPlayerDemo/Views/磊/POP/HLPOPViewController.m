//
//  HLPOPViewController.m
//  AVPlayerDemo
//
//  Created by hlznj on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "HLPOPViewController.h"

@interface HLPOPViewController ()

@end

@implementation HLPOPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW/2-150, 200, 300, 300)];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageNamed:@"POPImage.jpg"];
    [self.view addSubview:imageView];
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [imageView addGestureRecognizer:tap];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.backgroundColor = [UIColor redColor];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:label2];
}

- (void)tapAction:(UIGestureRecognizer *)ges
{
    static BOOL first = YES;
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    animation.springBounciness = 10.0;
    if (first) {
        animation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
    } else {
        animation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0)];
    }
    [ges.view.layer pop_addAnimation:animation forKey:@"animation"];
    first = !first;
}

@end
