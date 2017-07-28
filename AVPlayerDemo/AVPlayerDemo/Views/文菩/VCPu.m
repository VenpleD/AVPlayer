//
//  VCPu.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "VCPu.h"

@interface VCPu ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *viewControllerNameArray;

@end

static NSString *const Identifier = @"identifier";

@implementation VCPu

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController.view bringSubviewToFront:self.navigationController.navigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)configView {
    [self setTitle:@"venple"];
    [self.view addSubview:self.mainTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewControllerNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    cell.textLabel.text = self.viewControllerNameArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [[NSClassFromString(self.viewControllerNameArray[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        [_mainTableView setDelegate:self];
        [_mainTableView setDataSource:self];
        [_mainTableView setRowHeight:80];
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
        
    }
    return _mainTableView;
}

- (NSArray *)viewControllerNameArray {
    if (!_viewControllerNameArray) {
        _viewControllerNameArray = @[@"BezierViewController",
                                     @"FirstCircleViewController",
                                     @"SecondCircleViewController",
                                     @"ThirdCircleViewController",
                                     @"CopyViewController",
                                     @"HotelOrderViewController"];
    }
    return _viewControllerNameArray;
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
