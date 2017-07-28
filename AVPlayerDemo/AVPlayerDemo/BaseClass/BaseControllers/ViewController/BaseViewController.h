//
//  BaseViewController.h
//  AVPlayerDemo
//
//  Created by dev on 2017/6/21.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RACReplaySubject;
@class RACSubject;

@interface BaseViewController : UIViewController

@property (nonatomic, strong) RACSubject        *subjectForClosed;
@property (nonatomic, strong) RACReplaySubject  *replaySubjectForClosed;

@end
