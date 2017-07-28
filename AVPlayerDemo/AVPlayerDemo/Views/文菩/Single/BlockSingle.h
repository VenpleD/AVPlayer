//
//  BlockSingle.h
//  AVPlayerDemo
//
//  Created by duanwenpu on 17/7/20.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CircleBlock)(void);

@interface BlockSingle : NSObject

@property (nonatomic, copy) CircleBlock circleBlock;

+ (instancetype)shareBlock;

- (void)sendBlock:(CircleBlock)paramsBlock withControllerName:(NSString *)controllerName;

@end
