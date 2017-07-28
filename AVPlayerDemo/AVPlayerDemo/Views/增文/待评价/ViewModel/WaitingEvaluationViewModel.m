//
//  WaitingEvaluationViewModel.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "WaitingEvaluationViewModel.h"
#import "WaitingEvaluationShopModel.h"
@implementation WaitingEvaluationViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)requstData {
    NSString *dataPath = [[NSBundle mainBundle]pathForResource:@"WaitingEvaluationDataList" ofType:@"plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:dataPath];
    NSArray * listArray = [WaitingEvaluationShopModel mj_objectArrayWithKeyValuesArray:dataArray];
    !self.dataSourceArray ? :self.dataSourceArray(listArray);
    
}
@end
