//
//  PlayerView.h
//  AVPlayerDemo
//
//  Created by dev on 2017/6/22.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerView : UIView

@property (nonatomic, strong) NSString *urlStr; // 不需要深拷贝


//单例，用于列表cell上 多个视频
+ (instancetype)sharedPlayerView;



@end
