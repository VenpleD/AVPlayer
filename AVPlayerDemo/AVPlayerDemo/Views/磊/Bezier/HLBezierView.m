//
//  HLBezierView.m
//  AVPlayerDemo
//
//  Created by hlznj on 2017/6/29.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "HLBezierView.h"

//弧度转角度
#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation HLBezierView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
 /* 1.圆形  */
     // 圆形
     UIBezierPath *bPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 130) radius:30 startAngle:DEGREES_TO_RADIANS(120) endAngle:M_PI * 2 clockwise:YES];
     // 设置颜色
     [[UIColor redColor] setStroke];
     // 设置线宽
     [bPath setLineWidth:5];
     // 绘制
     [bPath stroke];
    
/* 2.椭圆  */
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 150, 100, 50)];
    [ovalPath setLineWidth:5];
    [ovalPath stroke];
    
/* 3.圆角矩形  */
    UIBezierPath *tBPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(10, 200, 50, 50) byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    [[UIColor greenColor] setStroke];
    [tBPath setLineWidth:5];
    [tBPath stroke];
    
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 15.0;
    aPath.lineCapStyle = kCGLineCapRound;  //线条终点
    //round 圆形
    //butt 平的 默认值 把线连接到精准的终点
    //Square 平的，会把线延伸到终点再加上线宽的一半
    aPath.lineJoinStyle = kCGLineJoinBevel;  //拐点处理
    //bevel 斜角斜面，角的外侧是平的不圆滑
    //miter 斜接 角的外侧是尖的
    //round 圆角
    
    //这是起点
    [aPath moveToPoint:CGPointMake(100.0, 200.0)];
    
    //添加点
    [aPath addLineToPoint:CGPointMake(200.0, 240.0)];
    [aPath addLineToPoint:CGPointMake(160, 340)];
    [aPath addLineToPoint:CGPointMake(40.0, 340)];
    [aPath addLineToPoint:CGPointMake(10.0, 240.0)];
    [aPath closePath]; //第五条线通过调用closePath方法得到的
    
    [aPath stroke]; //Draws line 根据坐标点连线
    
    
//
    UIBezierPath *cPath = [UIBezierPath bezierPath];
    cPath.lineWidth = 3;
    cPath.lineCapStyle = kCGLineCapRound;
    cPath.lineJoinStyle = kCGLineJoinRound;
    [cPath moveToPoint:CGPointMake(200, 100)];
//    [cPath addQuadCurveToPoint:CGPointMake(150, 200) controlPoint:CGPointMake(300, 250)];
    [cPath addCurveToPoint:CGPointMake(150, 200) controlPoint1:CGPointMake(300, 250) controlPoint2:CGPointMake(320, 300)];
    [cPath stroke];
}
 

@end
