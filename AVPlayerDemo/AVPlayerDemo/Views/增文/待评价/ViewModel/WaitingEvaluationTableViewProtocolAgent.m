//
//  WaitingEvaluationTableViewProtocolAgent.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/17.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "WaitingEvaluationTableViewProtocolAgent.h"
#import "WaitingEvaluationTableViewHeaderView.h"
#import "WaitingEvaluationViewModel.h"
#import "WaitingEvaluationGoodsModel.h"
#import "WaitingEvaluationTableViewCell.h"
#import "WaitingEvaluationTableViewFootView.h"


@interface WaitingEvaluationTableViewProtocolAgent ()

@end
@implementation WaitingEvaluationTableViewProtocolAgent

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WaitingEvaluationShopModel *shopModel = self.dataArray[section];
    NSArray *productArray = shopModel.goodsModel;
    return productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"WaitingEvaluationCell";
    WaitingEvaluationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[WaitingEvaluationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setModel:self.dataArray[indexPath.section].goodsModel[indexPath.row] shopType:self.dataArray[indexPath.section].shopTpye];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WaitingEvaluationTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([WaitingEvaluationTableViewHeaderView class])];
    headerView.shopName = self.dataArray[section].shopName;
    WEAK_SELF(self)
    headerView.evaluationBlcok = ^{
        STRONG_SELF(self)
        !self.objcBlock ? : self.objcBlock();
    };
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44.0f + 12.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    WaitingEvaluationTableViewFootView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([WaitingEvaluationTableViewFootView class])];
    footView.model = self.dataArray[section];
    return footView;
}

@end
