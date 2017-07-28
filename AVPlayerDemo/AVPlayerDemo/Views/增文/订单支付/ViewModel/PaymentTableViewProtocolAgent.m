//
//  PaymentTableViewProtocolAgent.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/22.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PaymentTableViewProtocolAgent.h"
#import "PaymentTableViewCell.h"

@interface PaymentTableViewProtocolAgent ()
@end

@implementation PaymentTableViewProtocolAgent

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return [self setTitleArray].count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *ary = [self setTitleArray][section];
    return ary.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentTableViewCell" forIndexPath:indexPath];
    NSArray * dataSourceArray = [self setTitleArray][indexPath.section][indexPath.row];
    [cell titleImage:[UIImage imageNamed:[dataSourceArray lastObject]] titleString:[dataSourceArray firstObject] goodsAllPrice:self.allPrcie];
    if (indexPath == self.index) {
        cell.isSelect = YES;
    } else {
        cell.isSelect = NO;
    }
    /// 判断是否是最后一行
    if (indexPath.row ==  [[self setTitleArray][indexPath.section] count] - 1) {
        cell.isLastLine = YES;
    }
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ///
    if (indexPath.section == 1 && indexPath.row == 2) {
    
    } else {
        self.index = indexPath;
        !self.selectBlcok ? : self.selectBlcok();
    }
 
}




- (NSArray *)setTitleArray {
    return @[@[@[@"积分支付",@"points_paid_normal"]],
             @[@[@"支付宝",@"icon_pay_alipay"],
               @[@"微信支付",@"icon_pay_wechat"],
               @[@"银联支付",@"union_pay"]]];
}


@end
