//
//  PaymentViewController.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/22.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "PaymentViewController.h"
#import "PaymentTableViewProtocolAgent.h"
#import "PaymentTableViewCell.h"
#import "PaymentTableViewHeaderView.h"
@interface PaymentViewController ()
@property (nonatomic, strong) UITableView *paymentTableView;
@property (nonatomic, strong) PaymentTableViewProtocolAgent *protocolAgent;
@property (nonatomic, strong) PaymentTableViewHeaderView *headerView;
@property (nonatomic, strong) UIButton *payButton;
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self payAddSubViews];
    [self payLayoutViews];
    [self addData];
    
}

- (void)payAddSubViews {
    [self.view addSubview:self.paymentTableView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.payButton];
}
- (void)payLayoutViews {
    [self.paymentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.bottom.equalTo(self.payButton.top);
        make.top.equalTo(self.headerView.bottom);
    }];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(0);
        make.top.equalTo(64);
        make.height.equalTo(95);
    }];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(-20);
        make.size.equalTo(CGSizeMake(kSCREEN_WIDTH - 30, 44));
    }];
}

- (void)addData {
    WEAK_SELF(self)
    self.protocolAgent.selectBlcok = ^{
        STRONG_SELF(self)
        [self.paymentTableView reloadData];
    };
    self.protocolAgent.allPrcie = self.payAllPrice;

    [self.headerView setImageURL:@"" allPrice: self.payAllPrice shopName:self.payShopModel.shopName];

    [self.payButton setTitle:[NSString stringWithFormat:@"确认支付(%.2f元)",self.payAllPrice] forState:UIControlStateNormal];
}


#pragma mark --- 点击购买按钮
- (void)pay {

    
}


#pragma mark --- 积分余额不足
- (void)notSufficientFunds {
    static  NSString *titi = @"积分余额不足";
    static NSString *message = @"积分账户余额：50000积分\n";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titi message:message preferredStyle:UIAlertControllerStyleAlert];
    //改变title的大小和颜色
    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:titi];
    [titleAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:13.f] range:NSMakeRange(0, titi.length)];
    [alertController setValue:titleAtt forKey:@"attributedTitle"];
    //改变message的大小和颜色
    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:message];
    [messageAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-light" size:13.f] range:NSMakeRange(0, message.length)];
    [messageAtt addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, (message.length - 10))];
    [alertController setValue:messageAtt forKey:@"attributedMessage"];
    
    [alertController addAction: [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    [alertController addAction: [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}



- (UITableView *)paymentTableView {
    if (!_paymentTableView) {
        _paymentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _paymentTableView.delegate = self.protocolAgent;
        _paymentTableView.dataSource = self.protocolAgent;
        [_paymentTableView registerClass:[PaymentTableViewCell class] forCellReuseIdentifier:@"PaymentTableViewCell"];
        _paymentTableView.tableFooterView = [UIView new];
        _paymentTableView.rowHeight = 60.f;
        _paymentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _paymentTableView;
}


- (PaymentTableViewProtocolAgent *)protocolAgent {
    if (!_protocolAgent) {
        _protocolAgent = [[PaymentTableViewProtocolAgent alloc]init];
        _protocolAgent.index = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return _protocolAgent;
}

-(PaymentTableViewHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[PaymentTableViewHeaderView alloc]init];
    }
    return _headerView;
}

- (UIButton *)payButton {
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.layer.masksToBounds = YES;
        _payButton.layer.cornerRadius  = 5.0f;
        _payButton.backgroundColor = [UIColor redColor];
        [_payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}


@end
