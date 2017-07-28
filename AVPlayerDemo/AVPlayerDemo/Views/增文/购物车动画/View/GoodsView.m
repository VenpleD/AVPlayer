//
//  GoodsView.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/6/30.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "GoodsView.h"
#define KcartWidth  KScreenW / 6.0

@interface GoodsView()
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) CGPoint starPoint;
@end
@implementation GoodsView

- (instancetype)initWithstarPoint:(CGPoint)starPoint endPoint:(CGPoint)endPoint subView:(UIView *)view viewContent:(viewContentBlock)block
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithstarPoint:(CGPoint)starPoint endPoint:(CGPoint)endPoint subView:(UIView *)view  {
    self = [super init];
    if (self) {
        _starPoint = starPoint;
        _endPoint = endPoint;
        self.center = _starPoint;
        self.bounds = CGRectMake(0, 0, 20, 20);
        self.backgroundColor = [UIColor orangeColor];
        [view addSubview:self];
        [self shopviewAnimation];
    }
    return self;
}

#pragma mark --- 动画
- (void)shopviewAnimation {
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1.5f animations:^{
            [self layerKeyFrameAnimation:self buttonCenter:_starPoint];
            self.bounds = CGRectMake(0, 0, 3, 3);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            !self.animationCompleteBlock ? :self.animationCompleteBlock();
        }];
        
        
    });
    
    
    
}






#pragma mark --- 贝塞尔曲线动画
-(void)layerKeyFrameAnimation:(UIView *)view buttonCenter:(CGPoint)point
{
    
    
    NSLog(@"####%f--%f",point.x,point.y);
    
    
    //创建一条贝塞尔
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    
    aPath.lineWidth = 5.0;//宽度
    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
    aPath.lineJoinStyle = kCGLineJoinRound;  //终点处理
    //起始点
    [aPath moveToPoint:point];
    
    // 终点
    CGPoint endPoint = CGPointMake (_endPoint.x, KScreenH - _endPoint.y - KcartWidth);
    
    //控制点
    CGFloat spacing =point.y - 98.833333 - 64 ;
    
    CGFloat x = point.x / 2;
    CGFloat y = spacing < 0  ? 64 : spacing;
    [aPath addQuadCurveToPoint:endPoint controlPoint:CGPointMake(x ,y)];
    //划线
    
    UIGraphicsBeginImageContext(view.bounds.size);
    [aPath stroke];
    [aPath fill];
    UIGraphicsEndImageContext();
    
    //变动的属性,keyPath后面跟的属性是CALayer的属性
    CAKeyframeAnimation *keyFA = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    //动画路径
    keyFA.path = aPath.CGPath;
    //该属性是一个数组，用以指定每个子路径(AB,BC,CD)的时间。如果你没有显式地对keyTimes进行设置，则系统会默认每条子路径的时间为：ti=duration/(帧数)，即每条子路径的duration相等
    //    keyFA.keyTimes = @[@(0.0),@(0.5),@(0.9),@(2)];
    //动画总时间
    keyFA.duration =1.5f;
    //重复次数，小于0无限重复
    keyFA.repeatCount = 1;
    
    /*
     这个属性用以指定时间函数，类似于运动的加速度
     kCAMediaTimingFunctionLinear//线性
     kCAMediaTimingFunctionEaseIn//淡入
     kCAMediaTimingFunctionEaseOut//淡出
     kCAMediaTimingFunctionEaseInEaseOut//淡入淡出
     kCAMediaTimingFunctionDefault//默认
     */
    keyFA.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    keyFA.fillMode = kCAFillModeForwards;
    
    keyFA.calculationMode = kCAAnimationPaced;
    
    //旋转的模式,auto就是沿着切线方向动，autoReverse就是转180度沿着切线动
    keyFA.rotationMode = kCAAnimationRotateAuto;
    
    //结束后是否移除动画
    keyFA.removedOnCompletion = NO;
    
    //添加动画
    [view.layer addAnimation:keyFA forKey:@""];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
