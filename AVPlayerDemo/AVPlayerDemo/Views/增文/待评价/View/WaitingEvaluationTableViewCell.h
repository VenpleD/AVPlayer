//
//  WaitingEvaluationTableViewCell.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitingEvaluationGoodsModel.h"
@interface WaitingEvaluationTableViewCell : UITableViewCell
- (void)setModel:(WaitingEvaluationGoodsModel *)model shopType:(NSInteger)type;

@end
