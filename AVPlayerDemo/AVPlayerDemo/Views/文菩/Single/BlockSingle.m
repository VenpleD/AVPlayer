//
//  BlockSingle.m
//  AVPlayerDemo
//
//  Created by duanwenpu on 17/7/20.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "BlockSingle.h"

@implementation BlockSingle

+ (instancetype)shareBlock {
    static BlockSingle *blockSingle;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        blockSingle = [[BlockSingle alloc] init];
    });
    return blockSingle;
    
}

- (void)sendBlock:(CircleBlock)paramsBlock withControllerName:(NSString *)controllerName {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (paramsBlock) {
            if ([controllerName isEqualToString:@"FirstCircleViewController"]) {
//            第一种用自己的一个属性去接受了这个局部变量的block
//            如果用属性接受，并且执行属性，那么单例的属性在程序的整个运行阶段是不可能释放的，所以就会造成block的内部对象不能释放，解决方法，要么自己手动在调用完成以后，加上self.circleBlock() = nil;要么在block的执行方法最后调用单例的属性，并且制空；
                NSLog(@"%@",paramsBlock);
                self.circleBlock = [paramsBlock copy];
                NSLog(@"copy后paramsBlock%@,paramsBlockCopy%@,circleBlock%@",paramsBlock, [paramsBlock copy],self.circleBlock);
                self.circleBlock();
//            。。。其他操作
                self.circleBlock = nil;
            } else if ([controllerName isEqualToString:@"SecondCircleViewController"]) {
                self.circleBlock = [paramsBlock copy];
                self.circleBlock();
            } else {
//            第二种直接调用局部变量block
//            这种局部调用时最好的，因为这种是不需要我们做其他处理的，局部变量执行完成以后就会释放
                paramsBlock();
            }

        }
    });
}

@end
