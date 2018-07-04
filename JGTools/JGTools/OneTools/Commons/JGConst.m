//
//  JGConst.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/14.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "JGConst.h"

// 通用间距
CGFloat const JGMargin = 5;

// 刷新时每次加载数据量
CGFloat const JGRefreshCount = 20;

//公司客服电话
NSString * const ZJBL_Tel_Number = @"037155525080";

//广告页
NSString *const adImageName = @"adImageName";

NSString *const adUrl = @"adUrl";


/** 首页 商品详情商品 规格 变化 通知名称 */
NSString * const JGHomePageGoodsSpecificationsAfterChangeNotification = @"JGHomePageGoodsSpecificationsAfterChangeNotification";

/**  采购 选择商品数量 变化 通知名称 */
NSString * const JGPurchasesSelGoodNumChangeNotification = @"JGPurchasesSelGoodNumChangeNotification";

/** 采购 支付后发起的通知 通知名称 */
NSString * const JGPurchasesAfterPayResultNotification = @"JGPurchasesAfterPayResultNotification";

/** 采购 商品 加入/移除 购物车 通知名称 */
NSString * const JGShopCarBuyNumberDidChangeNSNotification = @"JGShopCarBuyNumberDidChangeNSNotification";



/** 确认采购 创建多订单 需独立支付 通知名称 */
NSString * const JGCheckVCFinishSinglePayNotification = @"JGCheckVCFinishSinglePayNotification";

/** 跳到指定控制器界面 通知名称 */
NSString * const JGGoToVCNotification = @"JGGoToVCNotification";


/** 门店 门店管理 店铺类型改变 通知名称 */
NSString * const JGStoreShopTypeChangeNotification = @"JGStoreShopTypeChangeNotification";


/** 我的/门店 定位成功 点击选择位置时的 通知名称 */
NSString * const JGGetUserLocationSelectAddressNotification = @"JGGetUserLocationSelectAddressNotification";


/** 我的 久币商城 接触屏幕 通知名称 */
NSString * const JGMineLeaveTopNotification = @"JGMineLeaveTopNotification";



