//
//  WaitingEvaluationViewController.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/17.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "BaseViewController.h"
typedef void(^ClickEvaluationButtonObjcBlock)(UINavigationController * nav);
@interface WaitingEvaluationViewController : BaseViewController
@property (nonatomic, copy) ClickEvaluationButtonObjcBlock objcBlock;
@end
