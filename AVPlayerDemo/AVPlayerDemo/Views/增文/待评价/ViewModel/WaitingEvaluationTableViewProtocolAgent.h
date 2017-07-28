//
//  WaitingEvaluationTableViewProtocolAgent.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/17.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WaitingEvaluationShopModel.h"

typedef void(^TableViewDelegateBlock)(NSIndexPath *indexPath);
typedef void(^ClickEvaluationObjcProtocolAgentBlock)();

@interface WaitingEvaluationTableViewProtocolAgent : NSObject <UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSArray<WaitingEvaluationShopModel *> *dataArray;

@property (nonatomic, copy) TableViewDelegateBlock tableViewDelegateBlock;

@property (nonatomic, copy) ClickEvaluationObjcProtocolAgentBlock objcBlock;

@end
