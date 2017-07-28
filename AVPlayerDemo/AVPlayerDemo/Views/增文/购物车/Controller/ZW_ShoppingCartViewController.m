//
//  ZW_ShoppingCartViewController.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/7.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "ZW_ShoppingCartViewController.h"
#import "CartTableViewHeaderView.h"
#import "ShoppingCartTableViewProxy.h"
#import "ShoppingCartLogic.h"
#import "CartTableViewCell.h"
#import "ShoppingCartBottomView.h"
#import "OrderPaymentViewController.h"

@interface ZW_ShoppingCartViewController ()

@property (nonatomic, strong) UITableView *cartTableView;

/**
 购物车表格代理
 */
@property (nonatomic, strong) ShoppingCartTableViewProxy *shopCartTableViewProxy;

/**
 购物车逻辑
 */
@property (nonatomic, strong) ShoppingCartLogic *shoppingCartLogic;

/**
 编辑按钮
 */
@property (nonatomic, strong) UIButton *editButton;

/**
 底部视图
 */
@property (nonatomic, strong) ShoppingCartBottomView *bottomView;

@end

@implementation ZW_ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    [self latyoutSubView];
    [self dataWithLogic];
    [self addSubview];
    [self latyoutSubView];
}

- (void)dataWithLogic {
//    @weakify(self);

    WEAK_SELF(self)
    self.shoppingCartLogic.shoppingCartLogicRequestSuccess = ^(NSMutableArray *dataArray) {
        STRONG_SELF(self)
        self.shopCartTableViewProxy.dataArray = dataArray;
        [self.cartTableView reloadData];
    };

    self.shoppingCartLogic.shoppingCartLogicTotalPrice = ^(CGFloat totalPrice, NSInteger toalcount, BOOL isAllSelected) {
        STRONG_SELF(self)
        [self.bottomView configureShopcartBottomViewWithTotalPrice:totalPrice totalCount:toalcount isAllselected:isAllSelected];
        [self.cartTableView reloadData];
      // 底部视图
    };
    
    self.shoppingCartLogic.shoppingCartLogicHasEditAllProducts = ^(BOOL isEdit) {
        STRONG_SELF(self)
        [self.cartTableView reloadData];
    };
    
    self.shoppingCartLogic.shoppingCartLogicSettleForSelectedProducts = ^(CGFloat totalPrice,NSArray *selectProducts) {
        // 结算回调
        STRONG_SELF(self)
        NSLog(@"购物车：%@",selectProducts);
        OrderPaymentViewController * orderPaymentVC = [[OrderPaymentViewController alloc]init];
        orderPaymentVC.modelArray = selectProducts;
        orderPaymentVC.allPrice = totalPrice;
        [self.navigationController pushViewController:orderPaymentVC animated:YES];
    };
    
    self.shoppingCartLogic.shoppingCartLogicWillDeleteSelectedProducts = ^(NSArray *selectProducts) {
        STRONG_SELF(self)
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确认要删除这%ld个宝贝吗？", selectProducts.count] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.shoppingCartLogic deleteSelectedProducts:selectProducts];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    };
    self.shopcartCellEditiBlock = ^(BOOL isEditi) {
        STRONG_SELF(self)

        [self.shoppingCartLogic EditAllProductWithStatus:isEditi];
    };
    
    
    [self.shoppingCartLogic requestShopcartProductList];

}



- (UITableView *) cartTableView {
    if (!_cartTableView) {
        _cartTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _cartTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _cartTableView.delegate = self.shopCartTableViewProxy;
        _cartTableView.dataSource = self.shopCartTableViewProxy;
        [_cartTableView registerClass:[CartTableViewCell class] forCellReuseIdentifier:@"ShopcartCell"];
        [_cartTableView registerClass:[CartTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:@"ShopcartHeaderView"];
        _cartTableView.rowHeight = 90;
        _cartTableView.sectionFooterHeight = 10;
        _cartTableView.tableFooterView = [UIView new];
    }
    return _cartTableView;
}


- (ShoppingCartTableViewProxy *)shopCartTableViewProxy {
    if (!_shopCartTableViewProxy) {
        _shopCartTableViewProxy  = [[ShoppingCartTableViewProxy alloc]init];
        @weakify(self);
        _shopCartTableViewProxy.shopcartProxyProductSelectBlock = ^(BOOL isSelected, NSIndexPath *indexPath) {
            @strongify(self);
            [self.shoppingCartLogic selectProductAtIndexPath:indexPath isSelected:isSelected];
        };
        
        _shopCartTableViewProxy.shopcartProxyBrandSelectBlock = ^(BOOL isSelected, NSInteger section) {
            @strongify(self);
            [self.shoppingCartLogic selectBrandAtSection:section isSelected:isSelected];
        };
        
        _shopCartTableViewProxy.shopcartProxyChangeCountBlock = ^(NSInteger count, NSIndexPath *indexPath) {
            @strongify(self);
            [self.shoppingCartLogic changeCountAtIndexPath:indexPath count:count];
        };
        
        _shopCartTableViewProxy.shopcartProxyDeleteBlock = ^(NSIndexPath *indexPath) {
            @strongify(self);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确认要删除这个宝贝吗？" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.shoppingCartLogic deleteProductAtIndexPath:indexPath];
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        };
        
//        _shopCartTableViewProxy.shopcart
        
        
    }
    return _shopCartTableViewProxy;
}

- (ShoppingCartLogic *)shoppingCartLogic {
    if (!_shoppingCartLogic) {
        _shoppingCartLogic = [[ShoppingCartLogic alloc]init];
        
    }
    return _shoppingCartLogic;
}

- (ShoppingCartBottomView *)bottomView {
    if (!_bottomView){
        _bottomView = [[ShoppingCartBottomView alloc] init];
        
        WEAK_SELF(self)
        _bottomView.shopcartBotttomViewAllSelectBlock = ^(BOOL isSelected){
            STRONG_SELF(self)
            [self.shoppingCartLogic selectAllProductWithStatus:isSelected];
        };
        
        _bottomView.shopcartBotttomViewSettleBlock = ^(){
            STRONG_SELF(self)
            [self.shoppingCartLogic settleSelectedProducts];
        };
        
        _bottomView.shopcartBotttomViewDeleteBlock = ^(){
            STRONG_SELF(self)
            [self.shoppingCartLogic beginToDeleteSelectedProducts];
        };
    }
    return _bottomView;
}



- (UIButton *)editButton {
    if (_editButton == nil){
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(0, 0, 40, 40);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitle:@"完成" forState:UIControlStateSelected];
        [_editButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_editButton addTarget:self action:@selector(editButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

- (void)editButtonAction {
    self.editButton.selected = !self.editButton.isSelected;
    [self.bottomView changeShopcartBottomViewWithStatus:self.editButton.isSelected];
    !self.shopcartCellEditiBlock ? :self.shopcartCellEditiBlock(self.editButton.selected);
//    [self.cartTableView reloadData];
}

- (void)latyoutSubView {
    [self.cartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    
}
- (void)addSubview {
    UIBarButtonItem *editBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editButton];
    self.navigationItem.rightBarButtonItem = editBarButtonItem;
    [self.view addSubview:self.cartTableView];
    [self.view addSubview:self.bottomView];
}

//#pragma mark ---UITableView datesource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    
//    return 2;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//        return 2;
//    
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
//    return cell;
//   
//}
//
//#pragma mark --- UITabelView Delegate
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 30.0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CartTableViewHeaderView *headerView = [[CartTableViewHeaderView alloc]init];
//    if (section == 0) {
////        headerView.shopSelectButton.selected = YES;
//    }
////    headerView.shopName = @"老北京布鞋专营店";
//    return headerView;
//}
//
//
//
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return 20.0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *footView = [UIView new];
//    footView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    return footView;
//}
//



@end
