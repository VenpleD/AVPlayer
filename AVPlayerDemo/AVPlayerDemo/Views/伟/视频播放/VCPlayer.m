//
//  VCPlayer.m
//  AVPlayerDemo
//
//  Created by dev on 2017/6/22.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "VCPlayer.h"

@interface VCPlayer ()

@property (nonatomic ,strong ) AVPlayer *player;

@property (nonatomic, strong) RACSignal *signal;

@property (nonatomic, strong) UIButton *btn;

@end

@implementation VCPlayer

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
//    [self setSignalWithBtn];
//    [self signalWithImageView];
//    [self setupPlayerUI];
//    
//    //应用进入后台
//    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil]
//      takeUntil:self.rac_willDeallocSignal]
//     subscribeNext:^(id x) {
//         
////         AVPlayerStatusUnknown,
////         AVPlayerStatusReadyToPlay,
////         AVPlayerStatusFailed
//         
//         if (self.player.status == AVPlayerStatusReadyToPlay) {
//             [self.player pause];
//         }
//         
//     }];
}

- (void)setupUI{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
    self.btn = btn;
    [self.view addSubview:btn];
    
    //layout
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(100);
    }];
    
    DLog(@"-----btn:%f-----",self.btn.bounds.size.width);
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DLog(@"-----btn:%f-----",self.btn.bounds.size.width);
}


- (void)setSignalWithBtn{
    
    self.signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:@"YES"];
        [subscriber sendCompleted];
        
        return nil;
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.signal subscribeNext:^(NSString *str) {
        DLog(@"------str:%@----",str);
    }];
}


//界面消失
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        [self.player pause];
    }
}


- (void)setupPlayerUI{
    
    NSString *urlStr = @"http://baobab.wdjcdn.com/1456316686552The.mp4";
    NSURL *url = [NSURL URLWithString:urlStr];
    
    AVPlayer *player = [AVPlayer playerWithURL:url];
    self.player = player;
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerLayer.frame = CGRectMake(10, kNavigationAndStatusBarHeight, KScreenW - 20, 500);
    
    [self.view.layer addSublayer:playerLayer];
    
    [player play];
    
//    UIButton *playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    playBtn.backgroundColor = [UIColor grayColor];
//    [playBtn setCornerRadius:20];
//    
//    [playerLayer addSublayer:playBtn.layer];
    
    //layout
}

#pragma mark -
#pragma mark ---  后台线程发送请求，主线程刷新UI ---
- (void)signalWithImageView{
    
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor purpleColor];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
    //layout
    [imageView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(100);
    }];
    
    RAC(imageView, image) = [[RACSignal startEagerlyWithScheduler:[RACScheduler schedulerWithPriority:RACSchedulerPriorityBackground] block:^(id<RACSubscriber> subscriber) {
        
         NSError *error;
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ww3.sinaimg.cn/bmiddle/7128be06jw1ei4hfthoj3j20hs0bomyd.jpg"]
                                             options:NSDataReadingMappedAlways
                                               error:&error];
        if(error) {
            [subscriber sendError:error];
        }
        else {
            [subscriber sendNext:[UIImage imageWithData:data]];
            [subscriber sendCompleted];
        }
    }] deliverOn:[RACScheduler mainThreadScheduler]];
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
