//
//  ZJBLGoodsManager.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/27.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZJBLFMDBGoodsModel;

@interface ZJBLGoodsManager : NSObject

HMSingletonH(ZJBLGoodsManager)

//////////////////////////////////    增     ///////////////////////////////////
//添加一条记录  该商品整体模型 与 商品某一规格模型
- (void)addSupermarkProductToShopCarWithModel:(ZJBLFMDBGoodsModel *)Model;


//////////////////////////////////    删     ///////////////////////////////////
//删除一条记录 / 商品 校验成功 生成 预付订单 删除商品信息
- (void)deleteFromProductShopCarWithUNITID_ID:(NSString *)UNITID_ID ;


//////////////////////////////////    改     ///////////////////////////////////
//更新商品数量
- (void)updataSupermarkProductWithUNITID_ID:(NSString *)UNITID_ID ModifyBuyNum:(NSString *)BuyNum andModel:(ZJBLFMDBGoodsModel *)Model;

//根据 UNITID_ID 修改 每个商品的 编辑状态 是否被选中 未选中:0 选中:1
- (void)updataSingleGoodEditStateWithUNITID_ID:(NSString *)UNITID_ID andEditState:(NSString *)editState;

//根据 HOURSE_CODE 修改 每组头部右侧 编辑状态 是否编辑 未编辑:0 编辑:1
- (void)updateGroupGoodEditStateWithHOURSE_CODE:(NSString *)HOURSE_CODE andEditState:(NSString *)editState;

//根据HOURSE_CODE 修改 每组头部左侧 编辑状态 是否编辑 未编辑:0 编辑:1
- (void)updateGroupGoodTitleEditStateWithHOURSE_CODE:(NSString *)HOURSE_CODE andEditState:(NSString *)titleEdit;

//根据仓库代码获取 每组头部左侧状态 存在未选中 返回NO 否则返回YES
- (BOOL)updataGroupTitleEditStateWithHOURSE_CODE:(NSString *)HOURSE_CODE;

//采购页编辑 点击商品规格 更换商品规格
- (void)updataSupermarkProductWIthUNITID_ID:(NSString *)UNITID_ID andGoodModel:(ZJBLFMDBGoodsModel *)goodModel;

//采购页商品校验 --> 根据UNITID_ID 更改商品校验结果GOOD_CHECK
- (void)updataSupermarkProductWIthUNITID_ID:(NSString *)UNITID_ID andGOOD_CHECK:(NSString *)GOOD_CHECK;

//每次用户进入重置编辑为非编辑
- (void)resetUesrShopCarEditState;

//点击全选 修改 所有商品选中状态
- (void)updateGoodStateWithState:(NSString *)State;



//////////////////////////////////    查     ///////////////////////////////////
//获取商品数量
- (NSInteger)getSupermarkProductBuyCountWithUNITID_ID:(NSString *)UNITID_ID;

//根据UNITID_ID 获取单个商品价格
- (NSString *)getGoodsSinglePriceWithUNITID_ID:(NSString *)UNITID_ID;

//获取 所有 加入购物车商品 的 总数量
- (NSInteger)getAllGoodsNumber;

//获取 所有 加入购物车 选中商品 的 总数量
- (NSInteger)getAllSelGoodsNumber;

//判断是否全部选中 有问题 商品 不计
- (BOOL)isSelectedAll;

//获取已经勾选商品的总价格
- (double)getAllSelectGoodsTotalPrice;

//点击结算时 获取所有选中的商品信息 返回商品信息数组
- (NSArray *)getAllSelectGoods;

//获取所有的记录
- (NSMutableArray *)allGoods;

//是否存在某条记录
- (BOOL)isExist:(NSString *)UNIT_ID;


@end
