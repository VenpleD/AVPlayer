//
//  WaitingEvaluationViewModel.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^DataSourceArrayBlock)(NSArray *array);
@interface WaitingEvaluationViewModel : NSObject
@property (nonatomic, copy) DataSourceArrayBlock dataSourceArray;

- (void)requstData;
@end
