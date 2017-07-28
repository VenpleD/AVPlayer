//
//  ShoppingCartLogic.h
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/10.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShopModel;

typedef void(^ShoppingCartLogicRequestSuccessBlock)(NSMutableArray *dataArray);
typedef void(^ShoppingCartLogicTotalPriceBlock)(CGFloat totalPrice,NSInteger toalcount,BOOL isAllSelected);
typedef void(^ShoppingCartLogicSettleForSelectedProductsBlock)(CGFloat totalPrice,NSArray <ShopModel *>*selectProducts);
typedef void(^ShoppingCartLogicWillDeleteSelectedProductsBlock)(NSArray *selectProducts);
typedef void(^ShoppingCartLogicHasDeleteAllProductsBlock)();
typedef void(^ShoppingCartLogicHasEditAllProductsBlock)(BOOL isEdit);


@interface ShoppingCartLogic : NSObject
@property (nonatomic, copy) ShoppingCartLogicRequestSuccessBlock shoppingCartLogicRequestSuccess;
@property (nonatomic, copy) ShoppingCartLogicTotalPriceBlock shoppingCartLogicTotalPrice;
@property (nonatomic, copy) ShoppingCartLogicSettleForSelectedProductsBlock shoppingCartLogicSettleForSelectedProducts;
@property (nonatomic, copy) ShoppingCartLogicWillDeleteSelectedProductsBlock shoppingCartLogicWillDeleteSelectedProducts;
@property (nonatomic, copy) ShoppingCartLogicHasDeleteAllProductsBlock shoppingCartLogicHasDeleteAllProducts;
@property (nonatomic, copy) ShoppingCartLogicHasEditAllProductsBlock shoppingCartLogicHasEditAllProducts;

- (void)requestShopcartProductList;
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;
- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected;
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath;
- (void)beginToDeleteSelectedProducts;
- (void)deleteSelectedProducts:(NSArray *)selectedArray;
- (void)starProductAtIndexPath:(NSIndexPath *)indexPath;
- (void)starSelectedProducts;
- (void)selectAllProductWithStatus:(BOOL)isSelected;
- (void)EditAllProductWithStatus:(BOOL)isEdit;
- (void)settleSelectedProducts;



@end
