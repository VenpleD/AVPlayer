//
//  PayResultViewController.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/24.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PayResultViewController.h"
#import "PayResultHeaderView.h"
@interface PayResultViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (nonatomic, strong) UITableView *payResultTableView;
@end

@implementation PayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.payResultTableView];

    [self addheaderView];
    [self aa];

//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"icon_back_red"] forBarMetrics:UIBarMetricsDefault];
}
- (void)onTap {
    NSLog(@"返回");
}


- (void)aa {
    // 创建一个导航栏
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 44)];
    // 导航栏背景颜色
    navBar.barTintColor = [UIColor colorWithRed:101/255.0 green:215/255.0 blue:237/255.0 alpha:1.0];
    
    // 自定义导航栏的title，用UILabel实现
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    titleLabel.text = @"自定义";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    // 创建导航栏组件
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    // 设置自定义的title
    navItem.titleView = titleLabel;
    
    // 创建左侧按钮
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"leftButton" style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonClick)];
    leftButton.tintColor = [UIColor purpleColor];
    
    // 创建右侧按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"rightButton" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonClick)];
    rightButton.tintColor = [UIColor orangeColor];
    
    // 添加左侧、右侧按钮
    [navItem setLeftBarButtonItem:leftButton animated:false];
    [navItem setRightBarButtonItem:rightButton animated:false];
    // 把导航栏组件加入导航栏
    [navBar pushNavigationItem:navItem animated:false];
    
    // 导航栏添加到view上
    [self.view addSubview:navBar];
}

- (void)leftButtonClick {
     NSLog(@"返回");
}

- (void)rightButtonClick {
     NSLog(@"更多");
}
- (void)addheaderView {
    PayResultHeaderView *header = [[PayResultHeaderView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 230)];
    self.payResultTableView.tableHeaderView = header;
    
    
}

- (UITableView *)payResultTableView {
    if (!_payResultTableView) {
        _payResultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _payResultTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _payResultTableView.delegate = self;
        _payResultTableView.dataSource = self;
        [_payResultTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _payResultTableView.tableFooterView = [UIView new];
        
    }
    return _payResultTableView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerBgView = [UIView new];
    headerBgView.backgroundColor = [UIColor whiteColor];

    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, kSCREEN_WIDTH, 44.f)];
    titleLabel.text = @"为您推荐";
    titleLabel.font = [UIFont systemFontOfSize:13.f];
    [headerBgView addSubview:titleLabel];
    return headerBgView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return 10;
        
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    return cell;
    
    
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
