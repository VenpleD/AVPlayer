//
//  WaitingEvaluationTableViewFootView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitingEvaluationShopModel.h"
@interface WaitingEvaluationTableViewFootView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *payTimer;
@property (nonatomic, copy) NSString *goodsNumber;
@property (nonatomic, copy) NSString *allPrice;
@property (nonatomic, strong) WaitingEvaluationShopModel *model;
@end
