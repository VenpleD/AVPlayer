//
//  ViewController.m
//  BezierAnimation
//
//  Created by duanwenpu on 17/7/4.
//  Copyright © 2017年 duanwenpu. All rights reserved.
//

#import "BezierViewController.h"
#import "BezierTableViewCell.h"
#import "BezierView.h"

@interface BezierViewController ()<UITableViewDataSource, UITableViewDelegate,POPAnimationDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *storedViewArray;

@end


static NSString *const Identifier = @"identifier";

@implementation BezierViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)configView {
    for (NSInteger i = 0; i < 10; i ++) {
        BezierView *view = [[BezierView alloc] init];
        view.tag = 50;
        view.isAnim = NO;
        [self.storedViewArray addObject:view];
    }
    [self.view addSubview:self.mainTableView];
}

- (void)buttonClick:(BezierButton *)button {
    BezierView *view;
    for (BezierView *storedView in self.storedViewArray) {
        if (storedView && !storedView.isAnim) {
            storedView.isAnim = !storedView.isAnim;
            view = storedView;
            break;
        }
    }
    [view setUserInteractionEnabled:NO];
    
    CGRect rectInTableView = [self.mainTableView rectForRowAtIndexPath:button.indexPath];
    CGRect rect = [self.mainTableView convertRect:rectInTableView toView:[self.mainTableView superview]];
    
    [view setFrame:CGRectMake(button.frame.origin.x, rect.origin.y, button.frame.size.width, button.frame.size.height)];
    
    [view setBackgroundColor:[UIColor yellowColor]];
    [self.view addSubview:view];
    
    CGPoint originalPoint = CGPointMake(view.center.x, view.center.y);
    CGPoint terminalPoint = CGPointMake(0, self.view.frame.size.height);
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:originalPoint];
    CGFloat controlPointY = rect.origin.y - 120;
    CGPoint controlPoint = CGPointMake(160, controlPointY);
    [bezierPath addQuadCurveToPoint:terminalPoint controlPoint:controlPoint];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyFrameAnimation setDuration:0.68];
    keyFrameAnimation.path = bezierPath.CGPath;
    keyFrameAnimation.fillMode = kCAFillModeForwards;
    keyFrameAnimation.removedOnCompletion = NO;
    keyFrameAnimation.delegate = self;
    [view.layer addAnimation:keyFrameAnimation forKey:@"movingAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    BezierView *view = [self.view viewWithTag:50];
    view.isAnim = NO;
    [view removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BezierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    [cell.bezierButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.bezierButton.indexPath = indexPath;
    return cell;
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setRowHeight:80];
        [_mainTableView setAllowsSelection:NO];
        [_mainTableView registerClass:[BezierTableViewCell class] forCellReuseIdentifier:Identifier];

    }
    return _mainTableView;
}

- (NSMutableArray *)storedViewArray {
    if (!_storedViewArray) {
        _storedViewArray = [NSMutableArray array];
    }
    return _storedViewArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
