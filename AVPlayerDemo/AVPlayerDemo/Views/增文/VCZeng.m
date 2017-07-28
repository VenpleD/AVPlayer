//
//  VCZeng.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "VCZeng.h"
#import "ZW_TwoViewController.h"
#import "ZW_ShoppingCartViewController.h"
#import "EvaluateViewController.h"
#import "WaitingEvaluationViewController.h"
#import "OrderPaymentViewController.h"

@interface VCZeng ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CAShapeLayer *myShapeLayer;
@property (nonatomic, strong) UITableView *ZW_HomeTableView;
@property (nonatomic, strong) NSArray *sourceArray;
@end

@implementation VCZeng


// 我不信
// 我还是不信
// 我仍然不信
// 我在提交两次
// 一次

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    self.title = @"增";
}

-(UITableView *)ZW_HomeTableView {
    if (!_ZW_HomeTableView) {
        _ZW_HomeTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_ZW_HomeTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _ZW_HomeTableView.delegate = self;
        _ZW_HomeTableView.dataSource = self;
        _ZW_HomeTableView.tableFooterView = [UIView new];
        
    }
    return _ZW_HomeTableView;
}

- (NSArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = @[@[@"购物车动画",@"ZW_TwoViewController"],
                         @[@"购物车",@"ZW_ShoppingCartViewController"],
                          @[@"评价",@"EvaluateViewController"],
                         @[@"待评价",@"WaitingEvaluationViewController"],
                         @[@"订单支付",@"OrderPaymentViewController"],
                         @[@"支付结果",@"PayResultViewController"]];
        
    }
    return _sourceArray;
}
- (void)createView {
    
    [self.view addSubview:self.ZW_HomeTableView];

}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.sourceArray.count;
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text =  [self.sourceArray[indexPath.row]firstObject];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
  
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self jumpViewControll:indexPath];
}

- (void)jumpViewControll:(NSIndexPath *)indexPath {
    NSString *className = [self.sourceArray[indexPath.row]lastObject];
    UIViewController *vc = [[NSClassFromString(className) alloc]init];
    vc.title = [self.sourceArray[indexPath.row]firstObject];
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
