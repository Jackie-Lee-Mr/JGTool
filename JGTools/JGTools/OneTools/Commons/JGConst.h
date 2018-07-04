//
//  JGConst.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/14.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger ,HeadViewItemType){
//    HeadViewItemTypePage,
//    HeadViewItemTypeHot,
//    HeadViewItemTypeHeadLine,
//    HeadViewItemTypeBrand,
//    HeadViewItemTypeScene
//};


//typedef void(^ClikedCallback) (HeadViewItemType type,NSInteger tag);

/** 通用 间距 */
UIKIT_EXTERN CGFloat const JGMargin;

/** 刷新时 每次 加载 数据量 */
UIKIT_EXTERN CGFloat const JGRefreshCount;

//公司客服电话
UIKIT_EXTERN NSString * const ZJBL_Tel_Number;

//广告页
UIKIT_EXTERN NSString *const adImageName;
UIKIT_EXTERN NSString *const adUrl;

/** 首页 商品详情商品 规格 变化 通知名称 */
UIKIT_EXTERN NSString * const JGHomePageGoodsSpecificationsAfterChangeNotification;

/**  采购 选择商品数量 变化 通知名称 */
UIKIT_EXTERN NSString * const JGPurchasesSelGoodNumChangeNotification;

/** 采购 支付后发起的通知 通知名称 */
UIKIT_EXTERN NSString * const JGPurchasesAfterPayResultNotification;

/** 采购 商品 加入/移除 购物车 通知名称 */
UIKIT_EXTERN NSString * const JGShopCarBuyNumberDidChangeNSNotification;

/** 确认采购 创建多订单 需独立支付 通知名称 */
UIKIT_EXTERN NSString * const JGCheckVCFinishSinglePayNotification;


/** 跳到指定控制器界面 通知名称 */
UIKIT_EXTERN NSString * const JGGoToVCNotification;

/** 门店 门店管理 店铺类型改变 通知名称 */
UIKIT_EXTERN NSString * const JGStoreShopTypeChangeNotification;

/** 我的/门店 定位成功 点击选择位置时的 通知名称 */
UIKIT_EXTERN NSString * const JGGetUserLocationSelectAddressNotification;

/** 我的 久币商城 接触屏幕 通知名称 */
UIKIT_EXTERN NSString * const JGMineLeaveTopNotification;
