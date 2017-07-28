//
//  VCRAC.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/27.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#define KTitle      @"title"
#define KDetail     @"detail"

#import "VCRAC.h"

@interface VCRAC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataAry;

@end

@implementation VCRAC

- (NSMutableArray *)dataAry{
    if (!_dataAry) {
        
        _dataAry = [NSMutableArray arrayWithObjects:
                    @{KTitle:@"基本操作",KDetail:@"VCBasicOperators"},
                    @{KTitle:@"设计指南",KDetail:@"VCPlayer"},
                    @{KTitle:@"与Rx的区别",KDetail:@"VCRAC"},
                    @{KTitle:@"框架概述",KDetail:@"VCRAC"},
                    @{KTitle:@"内存管理",KDetail:@"VCRAC"},
                    nil];
    }
    return _dataAry;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    
    self.title = @"伟";
    [self.view addSubview:self.tableView];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -
#pragma mark --- DataSource ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

static NSString *identifier = @"identifier01";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [[self.dataAry objectAtIndexSafe:indexPath.row] objectForKey:KTitle];
    cell.detailTextLabel.text = [[self.dataAry objectAtIndexSafe:indexPath.row] objectForKey:KDetail];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *className = [[self.dataAry objectAtIndexSafe:indexPath.row] objectForKey:KDetail];
    BaseViewController *vc = [[NSClassFromString(className) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
