//
//  ShoppingCartTableViewProxy.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/10.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "ShoppingCartTableViewProxy.h"
#import "CartTableViewCell.h"
#import "ShopModel.h"
#import "GoodsModel.h"
#import "CartTableViewHeaderView.h"

@interface ShoppingCartTableViewProxy ()
@property (nonatomic, assign) NSInteger selIndexPath;

@end

@implementation ShoppingCartTableViewProxy
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ShopModel *brandModel = self.dataArray[section];
    NSArray *productArray = brandModel.goodsModel;
    return productArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopcartCell"];
    ShopModel *brandModel = self.dataArray[indexPath.section];
//    NSLog(@"2------%@",brandModel);

    NSArray *productArray = brandModel.goodsModel;
    if (productArray.count > indexPath.row) {
        GoodsModel *productModel = productArray[indexPath.row];
        
        [cell configureShopcartCellWithProductURL:productModel.goodsImageUrl productName:brandModel.shopName  productColor:productModel.goodsColor productSize:productModel.goodsSize productRecommendedSize:productModel.goodsRecommendedSize productPrice:productModel.goodsNewPrice productOldPrice:productModel.goodsOldPrice productCount:productModel.goodsQty productStock:productModel.goodsStocks productSelected:productModel.isSelected editing:productModel.isEdit];
        
        

    }
    
    WEAK_SELF(self)
    cell.shopcartCellBlock = ^(BOOL isSelected){
        STRONG_SELF(self)
        if (self.shopcartProxyProductSelectBlock) {
            self.shopcartProxyProductSelectBlock(isSelected, indexPath);
        }
    };
    cell.shopcartCellEditBlock = ^(NSInteger count){
        STRONG_SELF(self)
        if (self.shopcartProxyChangeCountBlock) {
            self.shopcartProxyChangeCountBlock(count, indexPath);
        }
    };
  

    return cell;
}

#pragma mark UITableViewDelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CartTableViewHeaderView *shopcartHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ShopcartHeaderView"];
    if (self.dataArray.count > section) {
        ShopModel *brandModel = self.dataArray[section];
    
        [shopcartHeaderView configureShopcartHeaderViewWithshopName:brandModel.shopName shopVariety:brandModel.shopVariety shopType:brandModel.shopTpye shopSelect:brandModel.isSelected];
    }
   
        WEAK_SELF(self)
        shopcartHeaderView.shopcartHeaderViewBlock = ^(BOOL isSelected){
            STRONG_SELF(self)
             !self.shopcartProxyBrandSelectBlock ? : self.shopcartProxyBrandSelectBlock(isSelected, section);
            
        };
  
    return shopcartHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        if (self.shopcartProxyDeleteBlock) {
            self.shopcartProxyDeleteBlock(indexPath);
        }
    }];
    
//    UITableViewRowAction *starAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"收藏" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        if (self.shopcartProxyStarBlock) {
//            self.shopcartProxyStarBlock(indexPath);
//        }
//    }];
    
    return @[deleteAction];
}

@end
