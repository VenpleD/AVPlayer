//
//  OrderPaymentViewController.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/19.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "OrderPaymentViewController.h"
#import "OrderPaymentTableViewProtocolAgent.h"
#import "OrderPaymentTableViewCell.h"
#import "OrderPaymentTableViewHeader.h"
#import "OrderPaymentBottomView.h"
#import "PaymentViewController.h"


@interface OrderPaymentViewController ()
@property (nonatomic, strong) UITableView *orderPaymentTableView;
@property (nonatomic, strong) OrderPaymentTableViewProtocolAgent *protocolAgent;
///
@property (nonatomic, strong) OrderPaymentBottomView *bottomView;
@end

@implementation OrderPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self addSubViews];
    [self layoutSubViews];
    [self transmitData];
  
}

/// 传输订单数据
- (void)transmitData {
     [self.bottomView setAllprice:self.allPrice];
    WEAK_SELF(self)
    self.bottomView.submitBlcok = ^ {
         NSLog(@"提交订单");
        STRONG_SELF(self)
        PaymentViewController *payVC = [[PaymentViewController alloc]init];
        payVC.payAllPrice = self.allPrice;
        payVC.payShopModel = [self.modelArray lastObject];
        [self.navigationController pushViewController:payVC animated:YES];
        
        
    };
}

/// 添加视图
- (void)addSubViews{
     [self.view addSubview:self.orderPaymentTableView];
    [self.view addSubview:self.bottomView];
    [self.view bringSubviewToFront:self.bottomView];
}

/// 布局视图
- (void)layoutSubViews {
    [self.orderPaymentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 50, 0));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(50);
    }];
    
}

- (UITableView *)orderPaymentTableView {
    if (!_orderPaymentTableView ) {
        _orderPaymentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _orderPaymentTableView.delegate = self.protocolAgent;
        _orderPaymentTableView.dataSource = self.protocolAgent;
        _orderPaymentTableView.rowHeight = 90;
        [_orderPaymentTableView registerClass:[OrderPaymentTableViewCell class] forCellReuseIdentifier:@"OrderPaymentTableViewCell"];
        [_orderPaymentTableView dequeueReusableHeaderFooterViewWithIdentifier:@"OrderPaymentTableViewHeader"];
        
    }
    return _orderPaymentTableView;
}

- (OrderPaymentTableViewProtocolAgent *)protocolAgent {
    if (!_protocolAgent) {
        _protocolAgent = [[OrderPaymentTableViewProtocolAgent alloc]init];
        _protocolAgent.orderPaymentDataArray = self.modelArray;
    }
    return _protocolAgent;
}

- (OrderPaymentBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[OrderPaymentBottomView alloc]initWithFrame:CGRectZero];
        
    }
    return _bottomView;
}

@end
