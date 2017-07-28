//
//  ShoppingCartLogic.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/10.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "ShoppingCartLogic.h"
#import "ShopModel.h"
#import "MJExtension.h"
#import "GoodsModel.h"
@interface ShoppingCartLogic()

@property (nonatomic, strong) NSMutableArray *shopcartListArray;    /**< 购物车数据源 */

@end

@implementation ShoppingCartLogic

- (void)requestShopcartProductList {
    //在这里请求数据 当然我直接用本地数据模拟的
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ShoppingCartData" ofType:@"plist"];
    NSMutableArray *dataArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
    self.shopcartListArray = [ShopModel mj_objectArrayWithKeyValuesArray:dataArray];

    //成功之后回调
    if (self.shoppingCartLogicRequestSuccess) {
        self.shoppingCartLogicRequestSuccess(self.shopcartListArray);
    }

//    !self.shoppingCartLogicRequestSuccessBlock ? : self.shoppingCartLogicRequestSuccessBlock();
    
}

- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected {

    /// 单选商家
    [self radioShop];
    
    ShopModel *brandModel = self.shopcartListArray[indexPath.section];
    GoodsModel *productModel = brandModel.goodsModel
    [indexPath.row];
    productModel.isSelected = isSelected;
    
    BOOL isBrandSelected = YES;
    
    for (GoodsModel *aProductModel in brandModel.goodsModel) {
        if (aProductModel.isSelected == NO) {
            isBrandSelected = NO;
        }
    }
    
    brandModel.isSelected = isBrandSelected;
    
    !self.shoppingCartLogicTotalPrice ? : self.shoppingCartLogicTotalPrice
    ([self accountTotalPrice],[self accountTotalCount],[self isAllSelected]);
    
    
    
}

- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected {
    
  /// 单选商家
    [self radioShop];
    ShopModel *brandModel = self.shopcartListArray[section];
    brandModel.isSelected = isSelected;
    for (GoodsModel *aProductModel in brandModel.goodsModel) {
        aProductModel.isSelected = brandModel.isSelected;
    }
    
    !self.shoppingCartLogicTotalPrice ? : self.shoppingCartLogicTotalPrice
    ([self accountTotalPrice],[self accountTotalCount],[self isAllSelected]);
}


#pragma mark --- 单选商家
- (void)radioShop{
    for (ShopModel *model  in self.shopcartListArray) {
        if (model.isSelected == 1) {
            model.isSelected = 0 ;
            for (GoodsModel *aProductModel in model.goodsModel) {
                aProductModel.isSelected = model.isSelected;
            }
        }
    }

}



- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count {
    ShopModel *brandModel = self.shopcartListArray[indexPath.section];
    GoodsModel *productModel = brandModel.goodsModel[indexPath.row];
    count = count <= 0 ? 1 : count;
    if (!productModel.goodsStocks) {
        count =count > 99 ? 99 :count;
        
    } else {
        if (count > productModel.goodsStocks) {
            count = productModel.goodsStocks;

        }
        
    }
    
   
    
    //根据请求结果决定是否改变数据
    productModel.goodsQty = count;
    
    !self.shoppingCartLogicTotalPrice ? : self.shoppingCartLogicTotalPrice([self accountTotalPrice],[self accountTotalCount],[self isAllSelected]);
    
}

- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath {
    ShopModel *brandModel = self.shopcartListArray[indexPath.section];
    GoodsModel *productModel = brandModel.goodsModel[indexPath.row];
    
    //根据请求结果决定是否删除
    [brandModel.goodsModel removeObject:productModel];
    if (brandModel.goodsModel.count == 0) {
        [self.shopcartListArray removeObject:brandModel];
    } else {
        if (!brandModel.isSelected) {
            BOOL isBrandSelected = YES;
            for (GoodsModel *aProductModel in brandModel.goodsModel) {
                if (!aProductModel.isSelected) {
                    isBrandSelected = NO;
                    break;
                }
            }
            
            if (isBrandSelected) {
                brandModel.isSelected = YES;
            }
        }
    }
    
    !self.shoppingCartLogicTotalPrice ? : self.shoppingCartLogicTotalPrice([self accountTotalPrice],[self accountTotalCount],[self isAllSelected]);
    
    
    if (self.shopcartListArray.count == 0) {
        
        !self.shoppingCartLogicHasDeleteAllProducts ? :self.shoppingCartLogicHasDeleteAllProducts();
    }
}

- (void)beginToDeleteSelectedProducts {
    NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
    for (ShopModel *brandModel in self.shopcartListArray) {
        for (GoodsModel *productModel in brandModel.goodsModel) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
    }
    !self.shoppingCartLogicWillDeleteSelectedProducts ? :self.shoppingCartLogicWillDeleteSelectedProducts(selectedArray);
}

- (void)deleteSelectedProducts:(NSArray *)selectedArray {
    //网络请求
    //根据请求结果决定是否批量删除
    NSMutableArray *emptyArray = [[NSMutableArray alloc] init];
    for (ShopModel *brandModel in self.shopcartListArray) {
        [brandModel.goodsModel removeObjectsInArray:selectedArray];
        
        if (brandModel.goodsModel.count == 0) {
            [emptyArray addObject:brandModel];
        }
    }
    
    if (emptyArray.count) {
        [self.shopcartListArray removeObjectsInArray:emptyArray];
    }
    !self.shoppingCartLogicTotalPrice ? : self.shoppingCartLogicTotalPrice([self accountTotalPrice],[self accountTotalCount],[self isAllSelected]);

    
    if (self.shopcartListArray.count == 0) {
        !self.shoppingCartLogicHasDeleteAllProducts ? :self.shoppingCartLogicHasDeleteAllProducts();
    }
}

- (void)starProductAtIndexPath:(NSIndexPath *)indexPath {
    //这里写收藏的网络请求
    
}

- (void)starSelectedProducts {
    //这里写批量收藏的网络请求
    
}

- (void)EditAllProductWithStatus:(BOOL)isEdit {
    for (ShopModel *brandModel in self.shopcartListArray) {
        for (GoodsModel *productModel in brandModel.goodsModel) {
            productModel.isEdit = isEdit;
        }
    }
    
    !self.shoppingCartLogicHasEditAllProducts ? : self.shoppingCartLogicHasEditAllProducts(isEdit);
}

- (void)selectAllProductWithStatus:(BOOL)isSelected {
    for (ShopModel *brandModel in self.shopcartListArray) {
        brandModel.isSelected = isSelected;
        for (GoodsModel *productModel in brandModel.goodsModel) {
            productModel.isSelected = isSelected;
        }
    }
    
    !self.shoppingCartLogicTotalPrice ? : self.shoppingCartLogicTotalPrice([self accountTotalPrice],[self accountTotalCount],[self isAllSelected]);
}

- (void)settleSelectedProducts {
    NSMutableArray *settleArray = [[NSMutableArray alloc] init];
    for (ShopModel *brandModel in self.shopcartListArray) {
        NSMutableArray *selectedArray = [[NSMutableArray alloc] init];
        for (GoodsModel *productModel in brandModel.goodsModel) {
            if (productModel.isSelected) {
                [selectedArray addObject:productModel];
            }
        }
        
        brandModel.selectedArray = selectedArray;
        
        if (selectedArray.count) {
            [settleArray addObject:brandModel];
        }
    }
    !self.shoppingCartLogicSettleForSelectedProducts ? :self.shoppingCartLogicSettleForSelectedProducts([self accountTotalPrice],settleArray);

}

#pragma mark private methods

- (CGFloat)accountTotalPrice {
    CGFloat totalPrice = 0.f;
    for (ShopModel *brandModel in self.shopcartListArray) {
        for (GoodsModel *productModel in brandModel.goodsModel) {
            if (productModel.isSelected) {
                totalPrice += productModel.goodsNewPrice * productModel.goodsQty;
            }
        }
    }
    
    return totalPrice;
}

- (NSInteger)accountTotalCount {
    NSInteger totalCount = 0;
    
    for (ShopModel *brandModel in self.shopcartListArray) {
        for (GoodsModel *productModel in brandModel.goodsModel) {
            if (productModel.isSelected) {
                totalCount += productModel.goodsQty;
            }
        }
    }
    
    return totalCount;
}

- (BOOL)isAllSelected {
    if (self.shopcartListArray.count == 0) return NO;
    
    BOOL isAllSelected = YES;
    
    for (ShopModel *brandModel in self.shopcartListArray) {
        if (brandModel.isSelected == NO) {
            isAllSelected = NO;
        }
    }
    
    return isAllSelected;
}

@end
