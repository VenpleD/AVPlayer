//
//  PlayerView.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/22.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

+ (instancetype)sharedPlayerView{
    static PlayerView *playerView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerView = [[PlayerView alloc] init];
    });
    return playerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

@end
