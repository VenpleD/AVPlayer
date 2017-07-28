//
//  WaitingEvaluationViewController.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/17.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "WaitingEvaluationViewController.h"
#import "WaitingEvaluationTableViewProtocolAgent.h"
#import "WaitingEvaluationTableViewHeaderView.h"
#import "WaitingEvaluationViewModel.h"
#import "WaitingEvaluationTableViewFootView.h"
#import "EvaluateViewController.h"

@interface WaitingEvaluationViewController ()
@property (nonatomic, strong) WaitingEvaluationTableViewProtocolAgent *protocolAgent;
@property (nonatomic, strong) UITableView *waitingEvaluationTableView;
@property (nonatomic, strong) WaitingEvaluationViewModel *viewModel;
@end

@implementation WaitingEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.waitingEvaluationTableView];
    [self setViewLayout];
    [self updata];
    [self.viewModel requstData];
}

- (void)setViewLayout {
    [self.waitingEvaluationTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)updata {
    WEAK_SELF(self)
    self.viewModel.dataSourceArray = ^(NSArray *array) {
        STRONG_SELF(self)
        self.protocolAgent.dataArray = array;
        [self.waitingEvaluationTableView reloadData];
    };
    
    self.protocolAgent.objcBlock = ^{
        STRONG_SELF(self)
        EvaluateViewController * evaluate = [[EvaluateViewController alloc]init];
        [self.navigationController pushViewController:evaluate animated:YES];
    };
    
}


- (UITableView *)waitingEvaluationTableView {
    if (!_waitingEvaluationTableView) {
        _waitingEvaluationTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _waitingEvaluationTableView.delegate = self.protocolAgent;
        _waitingEvaluationTableView.dataSource = self.protocolAgent;
        [_waitingEvaluationTableView registerClass:[WaitingEvaluationTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([WaitingEvaluationTableViewHeaderView class])];
        [_waitingEvaluationTableView registerClass:[WaitingEvaluationTableViewFootView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([WaitingEvaluationTableViewFootView class])];
        _waitingEvaluationTableView.rowHeight = 85.0f;
        
    }
    return _waitingEvaluationTableView;
}

- (WaitingEvaluationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[WaitingEvaluationViewModel alloc]init];
    }
    return _viewModel;
}

- (WaitingEvaluationTableViewProtocolAgent *)protocolAgent {
    if (!_protocolAgent) {
        _protocolAgent = [[WaitingEvaluationTableViewProtocolAgent alloc]init];
    }
    return _protocolAgent;
}

@end
