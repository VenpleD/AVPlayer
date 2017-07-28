//
//  GoodsView.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/6/30.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^viewContentBlock)(UIImage *image ,NSString *title);
@interface GoodsView : UIView
@property (nonatomic, copy) void(^animationCompleteBlock)();



- (instancetype)initWithstarPoint:(CGPoint)starPoint endPoint:(CGPoint)endPoint subView:(UIView *)view ;




@end
