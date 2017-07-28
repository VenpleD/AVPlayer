//
//  WaitingEvaluationTableViewHeaderView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/17.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^ClickEvaluationButtonBlock)();

@interface WaitingEvaluationTableViewHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, copy) ClickEvaluationButtonBlock evaluationBlcok;

@end
