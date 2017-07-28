//
//  OrderPaymentTableViewProtocolAgent.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/21.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "OrderPaymentTableViewProtocolAgent.h"
#import "OrderPaymentTableViewCell.h"
#import "OrderPaymentTableViewHeader.h"

@implementation OrderPaymentTableViewProtocolAgent

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    /// 由于购物车只能提交一个商家的商品
    return self.orderPaymentDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.orderPaymentDataArray[section].goodsModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderPaymentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderPaymentTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.orderPaymentDataArray[indexPath.section].goodsModel[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f + 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    OrderPaymentTableViewHeader *headerView = [[OrderPaymentTableViewHeader alloc]initWithReuseIdentifier:@"OrderPaymentTableViewHeader"];
    headerView.model = self.orderPaymentDataArray[section];
    return headerView;
}
@end
