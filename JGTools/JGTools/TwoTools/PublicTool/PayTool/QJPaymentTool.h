//
//  QJPaymentTool.h
//  LH_QJ
//
//  Created by 郭军 on 2018/5/10.
//  Copyright © 2018年 LHYD. All rights reserved.
//  微信支付 支付宝支付 账户余额支付工具

#import <Foundation/Foundation.h>

//支付返回的可能Code码枚举出来
typedef NS_ENUM(NSInteger, PayCode) { 
    WXPAYEXIT              = -2,   /**< 微信退出支付    */
    WXPAYERROR             = -1,   /**< 微信支付失败    */
    WXPAYSUCCESS           = 0,    /**< 微信支付成功    */
    
    WXERROR_NOTINSTALL  = 1004,   /**< 未安装微信   */
    WXERROR_UNSUPPORT   = 1005,   /**< 微信不支持    */
    WXERROR_PARAM       = 1006,   /**< 支付参数解析错误   */
    
    ALIPAYERROR         = 4000,   /**< 支付宝支付失败 */
    ALIPAYCANCEL        = 6001,   /**< 支付宝支付中途取消 */
    ALIPAYNETError      = 6002,   /**< 支付宝网络连接出错 */
    ALIPAYNDETAIL       = 8000,   /**< 支付宝处理中 */
    ALIPAYSUCESS        = 9000,   /**< 支付宝支付成功 */

};


typedef void(^PaySuccess)(PayCode code, NSString *message);
typedef void(^PayFailure)(PayCode code, NSString *message);


@interface QJPaymentTool : NSObject


/**
 *  获取单例
 */
+ (instancetype)sharedPayment;

/**
 *  发起微信支付请求
 *
 *  @param pay_param    支付参数 json串
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)wxPayWithPayParam:(NSString *)pay_param
                  success:(PaySuccess)successBlock
                  failure:(PayFailure)failBlock;

/**
 *  发起支付宝支付请求
 *
 *  @param pay_param    支付参数，订单信息
 *  @param successBlock 成功
 *  @param failBlock    失败
 */
- (void)aliPayWithPayParam:(NSString *)pay_param
                   success:(PaySuccess)successBlock
                   failure:(PayFailure)failBlock;


/************* 回调入口 *****************/
- (BOOL) handleOpenURL:(NSURL *) url;


- (BOOL) sourceApplicationOpenURL:(NSURL *) url;


- (BOOL) OpenURL:(NSURL *) url;


@end
