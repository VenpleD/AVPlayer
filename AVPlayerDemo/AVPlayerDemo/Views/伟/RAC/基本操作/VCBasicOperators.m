//
//  VCBasicOperators.m
//  AVPlayerDemo
//
//  Created by dev on 2017/7/5.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "VCBasicOperators.h"

@interface VCBasicOperators ()

@end

@implementation VCBasicOperators

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*    用信号执行的操作    */
    //  Subscription  （订阅）
    //    [self signalWithSubscribeFunction];
//    [self signalWithColdSignal];
    //  Injecting effects (注射效果)
//    [self signalWithDoFunction];
    
    /*    转换流     */
//    [self signalWithMapFunction]; //映射map
//    [self signalWithFilterFunction];// 过滤 filter
    
    /*      组合流     */
    //串联
//    [self signalWithConcatFunction];
    //压缩 序列连接
//    [self signalWithFlatteningFunction];
//    [self signalWithMergedFunction];
    //扁平映射
//    [self signalWithFlattenMapFunction];
    
    /*      组合信号        */
    //序列
//    [self signalWithThanFunction];
    //合并
//    [self signalWithMergeFunction];
    //组合成新值
//    [self signalCombineLatestFunction];
    //交换
    [self signalWithSwitchingFunction];
    
}

#pragma mark -
#pragma mark --- subscribe 方法可以让你访问信号中的当前和未来值 ---
- (void)signalWithSubscribeFunction{
    
    RACSignal *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;
    
    //输出 A B C D E ……
    
    [letters subscribeNext:^(NSString *x) {
        
        DLog(@"------X:%@-----",x);
        
    }];
    
}

#pragma mark -
#pragma mark --- 对于冷信号订阅只执行一次操作 ---
- (void)signalWithColdSignal{
    
    __block unsigned subscriptions = 0;
    
    RACSignal *loggingSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        subscriptions ++;
        [subscriber sendCompleted];
        return nil;
    }];
    
    //output
    //subscrition 1
    [loggingSignal subscribeNext:^(id x) {
       
        DLog(@"-----111:%d-----",subscriptions);
        
    }];
    
    //subscrition 2
    [loggingSignal subscribeNext:^(id x) {
        
         DLog(@"-----222:%d-----",subscriptions);
        
    }];
    
}

#pragma mark -
#pragma mark --- 使用 -do……方法对信号添加副作用，而不实际订阅它 ---
- (void)signalWithDoFunction{
    
    __block unsigned subscriptions = 0;
    
    RACSignal *loggingSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        subscriptions ++;
        [subscriber sendCompleted];
        return nil;
    }];
    
    loggingSignal = [loggingSignal doCompleted:^{
        
        DLog(@"-----111:%d-----",subscriptions);
        
    }];
    
    [loggingSignal subscribeNext:^(id x) {
        
         DLog(@"-----222:%d-----",subscriptions);
        
    }];
}

#pragma mark -
#pragma mark --- map（映射） ---
- (void)signalWithMapFunction{
    
    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    
    RACSequence *mapped = [letters map:^id(id value) {
        return [value stringByAppendingString:value];
    }];
    
    [mapped.signal subscribeNext:^(NSString *x) {
        DLog(@"-----111:%@-----",x);
    }];
}

#pragma mark -
#pragma mark --- filter (过滤) ---
- (void)signalWithFilterFunction{
    
    RACSequence *numberSequence = [@"1 2 3 4 5 6 7 8 9 10" componentsSeparatedByString:@" "].rac_sequence;
    
    [[numberSequence filter:^BOOL(NSString *value) {
        return (value.integerValue % 2) == 0;
    }].signal subscribeNext:^(NSString *x) {
        DLog(@"-----222:%@-----",x);
    }];
    
}

#pragma mark -
#pragma mark --- concat(组合) ---
- (void)signalWithConcatFunction{
    
    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    
    [[letters concat:numbers].signal
    subscribeNext:^(NSString *x) {
        DLog(@"-----333:%@-----",x);
    }];
    
}

#pragma mark -
#pragma mark --- Flattening (压缩？ 序列连接) ---
- (void)signalWithFlatteningFunction{
    RACSequence *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence;
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;

    [[@[ letters, numbers ].rac_sequence flatten].signal
    subscribeNext:^(id x) {
         DLog(@"-----444:%@-----",x);
    }];
    
}

#pragma mark -
#pragma mark --- 信号合并 ---
- (void)signalWithMergedFunction{
    
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    RACSignal *signalOfSignals = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [subscriber sendNext:letters];
        [subscriber sendNext:numbers];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *flattened = [signalOfSignals flatten];
    
    //Outputs: A 1 B C 2
    [flattened subscribeNext:^(id x) {
         DLog(@"-----555:%@-----",x);
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    
}

#pragma mark -
#pragma mark --- 扁平映射 ---
- (void)signalWithFlattenMapFunction{
    
    RACSequence *numbers = [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence;
    
    // Contains: 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9
    RACSequence *extended = [numbers flattenMap:^RACStream *(NSString *value) {
        return @[value, value].rac_sequence;
    }];
    
    RACSequence *edited = [numbers flattenMap:^RACStream *(NSString *value) {
        
        if (value.integerValue % 2 == 0) {
            return [RACSequence empty];
        }else{
            NSString *newNum = [value stringByAppendingString:@"_"];
            return [RACSequence return:newNum];
        }
        
    }];
    
    [extended.signal subscribeNext:^(id x) {
        DLog(@"-----666:%@-----",x);
    }];
    
    [edited.signal subscribeNext:^(id x) {
        DLog(@"-----777:%@-----",x);
    }];
    
}

#pragma mark -
#pragma mark --- 序列 ---
- (void)signalWithThanFunction{
    
    RACSignal *letters = [@"A B C D E F G H I" componentsSeparatedByString:@" "].rac_sequence.signal;
    
    [[[letters doNext:^(NSString *x) {
        DLog(@"-----888:%@-----",x);
    }]then:^RACSignal *{
        return [@"1 2 3 4 5 6 7 8 9" componentsSeparatedByString:@" "].rac_sequence.signal;
    }] subscribeNext:^(id x) {
        DLog(@"------999:%@-----",x)
    }];
    
}

#pragma mark -
#pragma mark --- merge(合并) ---
- (void)signalWithMergeFunction{
    
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    RACSignal *merged = [RACSignal merge:@[letters, numbers]];
    
    [merged subscribeNext:^(id x) {
        DLog(@"-----111:%@----",x);
    }];
    
    [letters sendNext:@"A"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"B"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
    
}

#pragma mark -
#pragma mark --- 合并成新值 ---
- (void)signalCombineLatestFunction{
    
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    RACSignal *combined = [RACSignal combineLatest:@[letters, numbers] reduce:^(NSString *letter, NSString *number){
        return [letter stringByAppendingString:number];
    }];
    
    [combined subscribeNext:^(id x) {
        DLog(@"-----X:%@-----",x);
    }];
    
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [numbers sendNext:@"2"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"3"];
    
}

#pragma mark -
#pragma mark --- switching(交换) ---
- (void)signalWithSwitchingFunction{
    
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *signalOfSignals = [RACSubject subject];
    
    RACSignal *switched = [signalOfSignals switchToLatest];
    
    // Outputs: A B 1 D
    [switched subscribeNext:^(id x) {
        DLog(@"----X:%@----",x);
    }];
    
    [signalOfSignals sendNext:letters];
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    
    [signalOfSignals sendNext:numbers];
    [letters sendNext:@"C"];
    [numbers sendNext:@"1"];
    
    [signalOfSignals sendNext:letters];
    [numbers sendNext:@"2"];
    [letters sendNext:@"D"];
    
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
