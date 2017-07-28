//
//  TwoViewController.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/6/22.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "ZW_TwoViewController.h"
#import "ZW_ShoppingCartView.h"
#import "GoodsView.h"
#import "MessageBUtton.h"

@interface ZW_TwoViewController ()
@property (nonatomic, strong) ZW_ShoppingCartView *shoppingView;
@property (nonatomic, strong) UIView *shopView;
@property (nonatomic, strong) UIButton *btn ;
@property (nonatomic, assign) NSInteger messageNumer;
@end

@implementation ZW_TwoViewController

- (ZW_ShoppingCartView *)shoppingView {
    if (!_shoppingView) {
        _shoppingView = [[ZW_ShoppingCartView alloc]initWithFrame: CGRectMake(0 ,KScreenH - 60 , KScreenW, 60)];
    }
    return _shoppingView;
}

//- (UIView *)shopView {
//    
//        _shopView.frame = CGRectMake(0, 0, 0, 0);
//    return _shopView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.shoppingView];

    
    [self createButtons];
    
  
    self.shoppingView.zw_Account = ^{
        NSLog(@"我跳转了购物车界面");
    };

}


#pragma mark --- 按钮们 
- (void)createButtons {
    
    

     NSMutableArray *array = [NSMutableArray array];
    
    
    
    @weakify(self);
    for (NSInteger i = 0; i < 7; i ++) {
        MessageButton *btn4 = [MessageButton buttonWithType:UIButtonTypeCustom];
        [btn4 bk_addEventHandler:^(id  _Nonnull sender) {
            @strongify(self);
            self.messageNumer ++;
            btn4.numerString = [NSString stringWithFormat:@"%ld",self.messageNumer];
            GoodsView *view = [[GoodsView alloc]initWithstarPoint:btn4.center endPoint:self.shoppingView.cartImageView.center subView:self.view];
            [view setAnimationCompleteBlock:^{
                [self.shoppingView showView];
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        btn4.backgroundColor = [UIColor greenColor];
        
        
        [self.view addSubview:btn4];
        
        [array addObject:btn4];
    }
    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:20 leadSpacing:64 tailSpacing:64];

    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-30);
    }];
}





#pragma mark --- 动画
- (void)shopviewFrame:(UIButton *)button {
   
    UIView *shopView = [[UIView alloc]init];
   shopView.center = button.center;
   shopView.bounds = CGRectMake(0, 0, 20, 20);
   shopView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:shopView];

        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:1.5f animations:^{
                [self layerKeyFrameAnimation:shopView buttonCenter:button.center];
                shopView.bounds = CGRectMake(0, 0, 3, 3);
            } completion:^(BOOL finished) {
                [shopView removeFromSuperview];
                [self.shoppingView showView];
                
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
    CGPoint endPoint = CGPointMake (self.shoppingView.cartImageView.center.x, kSCREEN_HEIGHT - self.shoppingView.cartImageView.center.y - self.shoppingView.cartImageView.frame.size.height);
    
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








-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSLog(@"---购物车：%f",self.shoppingView.cartImageView.center.x);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.shoppingView showView];

}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
//    [self.shoppingView removeFromSuperview];
}

- (void)scaleToSmall
{
//    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(0.95f, 0.95f)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSmallAnimation"];
}

- (void)scaleAnimation
{
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//    scaleAnimation.springBounciness = 18.0f;
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
}

- (void)scaleToDefault
{
//    POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"layerScaleDefaultAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
