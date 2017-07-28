//
//  VCLei.m
//  AVPlayerDemo
//
//  Created by hlznj on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "VCLei.h"

@interface VCLei ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation VCLei

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.title = @"磊";
    [NSString stringWithFormat:@""];
    [self.view addSubview:self.tableView];
}

//多个参数
- (int)add:(int)item,...{
    va_list list;
    va_start(list, item);
    int result = 0;
    result += item;
    int arg;
    while ((arg=va_arg(list, int))) {
        result+=arg;
    }
    va_end(list);
    return result;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"VCLeiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self titleAtIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *VCName = [self vcAtIndexPath:indexPath];
    UIViewController *VC = [NSClassFromString(VCName) new];
    VC.hidesBottomBarWhenPushed = YES;
    VC.title = [self titleAtIndexPath:indexPath];
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 懒加载
- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = @[@[@"AV",@"HLAVViewController"],
                        @[@"POP",@"HLPOPViewController"],
                        @[@"GPU",@"HLGPUImageViewController"],
                        @[@"Bezier",@"HLBezierViewController"],
                        @[@"ClearTable",@"ClearTableViewController"]
                        ];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH-64-49) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource[indexPath.row] firstObject];
}

- (NSString *)vcAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.dataSource[indexPath.row] lastObject];
}

@end
