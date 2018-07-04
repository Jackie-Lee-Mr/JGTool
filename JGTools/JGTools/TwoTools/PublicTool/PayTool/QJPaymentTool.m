//
//  QJPaymentTool.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/10.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJPaymentTool.h"

#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>



@interface QJPaymentTool() <WXApiDelegate>

@property (nonatomic, copy) PaySuccess IndexPaySuccess;
@property (nonatomic, copy) PayFailure IndexPayFailure;


@end


@implementation QJPaymentTool

static id _instance;

+ (instancetype)sharedPayment {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[QJPaymentTool alloc] init];
    });
    
    return _instance;
}



///微信支付
- (void)wxPayWithPayParam:(NSString *)pay_param
                  success:(PaySuccess)successBlock
                  failure:(PayFailure)failBlock {
    self.IndexPaySuccess = successBlock;
    self.IndexPayFailure = failBlock;
    
    //解析结果
    NSData * data = [pay_param dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(error != nil) {
        failBlock(WXERROR_PARAM, @"参数有误");
        return ;
    }
    
    
    NSString *appid = dic[@"appid"];
    NSString *partnerid = dic[@"partnerid"];
    NSString *prepayid = dic[@"prepayid"];
    NSString *package = @"Sign=WXPay";
    NSString *noncestr = dic[@"noncestr"];
    NSString *timestamp = dic[@"timestamp"];
    NSString *sign = dic[@"sign"];
    
    [WXApi registerApp:appid];
    
    if(![WXApi isWXAppInstalled]) {
        failBlock(WXERROR_NOTINSTALL, @"未安装");
        return ;
    }
    if (![WXApi isWXAppSupportApi]) {
        failBlock(WXERROR_UNSUPPORT, @"不支持");
        return ;
    }
    
    
    //发起微信支付
    PayReq* req   = [[PayReq alloc] init];
    //微信分配的商户号
    req.partnerId = partnerid;
    //微信返回的支付交易会话ID
    req.prepayId  = prepayid;
    // 随机字符串，不长于32位
    req.nonceStr  = noncestr;
    // 时间戳
    req.timeStamp = timestamp.intValue;
    //暂填写固定值Sign=WXPay
    req.package   = package;
    //签名
    req.sign      = sign;
    [WXApi sendReq:req];
//
//    //日志输出
//    JGLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",appid,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
}




#pragma mark 支付宝支付
- (void)aliPayWithPayParam:(NSString *)pay_param
                   success:(PaySuccess)successBlock
                   failure:(PayFailure)failBlock
{
    self.IndexPaySuccess = successBlock;
    self.IndexPayFailure = failBlock;
    
    NSString * appScheme =  @"alisdkqj";
    
    // NOTE: 调用支付结果开始支付
    WEAKSELF;
    [[AlipaySDK defaultService] payOrder:pay_param fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        
        //回到支付前控制器
        [weakSelf ALiPayResultWithDict:resultDic];
        
    }];
    
}



///回调处理
- (BOOL) handleOpenURL:(NSURL *) url
{
    
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    if(url != nil && [[url host] isEqualToString:@"pay"]){//微信支付
        
        return [WXApi handleOpenURL:url delegate:self];
    } else if (url != nil &&  [url.host isEqualToString:@"safepay"]) { //支付宝支付
        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            JGLog(@"result222 = %@",resultDic);
            //回到支付前控制器
            [self ALiPayResultWithDict:resultDic];
        }];
        
        
    }else if (url != nil &&  [url.host isEqualToString:@"platformapi"]) { //支付宝钱包
        //支付宝钱包快登授权返回authCode
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        ////【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            JGLog(@"result = %@",resultDic);
            //回到支付前控制器
            if ([[resultDic allKeys] containsObject:@"resultStatus"]) {
                [self ALiPayResultWithDict:resultDic];
            }
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            JGLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    return NO;
}






- (BOOL) sourceApplicationOpenURL:(NSURL *) url {
    
    if(url != nil && [[url host] isEqualToString:@"pay"]) {//微信支付
        
        return [WXApi handleOpenURL:url delegate:self];
    } else if (url != nil && [url.host isEqualToString:@"safepay"]) { //支付宝支付
        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            JGLog(@"result111 = %@",resultDic);
            [self ALiPayResultWithDict:resultDic];
        }];
        
    }else if (url != nil && [url.host isEqualToString:@"platformapi"]) {
        //支付宝钱包快登授权返回authCode
        // 授权跳转支付宝钱包进行支付，处理支付结果
        ////【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            JGLog(@"授权result = %@",resultDic);
            //回到支付前控制器
            if ([[resultDic allKeys] containsObject:@"resultStatus"]) {
                [self ALiPayResultWithDict:resultDic];
            }
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            JGLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    return YES;
}


- (BOOL) OpenURL:(NSURL *) url {
    
    //这里判断是否发起的请求为微信支付，如果是的话，用WXApi的方法调起微信客户端的支付页面（://pay 之前的那串字符串就是你的APPID，）
    if(url != nil && [[url host] isEqualToString:@"pay"]){//微信支付
        
        return [WXApi handleOpenURL:url delegate:self];
    } else if (url != nil &&  [url.host isEqualToString:@"safepay"]) { //支付宝支付
        //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
        
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            JGLog(@"result222 = %@",resultDic);
            //回到支付前控制器
            [self ALiPayResultWithDict:resultDic];
        }];
        
        
    }else if (url != nil &&  [url.host isEqualToString:@"platformapi"]) { //支付宝钱包
        //支付宝钱包快登授权返回authCode
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        ////【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            JGLog(@"result = %@",resultDic);
            //回到支付前控制器
            if ([[resultDic allKeys] containsObject:@"resultStatus"]) {
                [self ALiPayResultWithDict:resultDic];
            }
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            JGLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    return YES;
    
}


#pragma mark - 微信回调
// 微信终端返回给第三方的关于支付结果的结构体
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        switch (resp.errCode) {
            case WXPAYSUCCESS: //支付成功
                
                self.IndexPaySuccess(WXPAYSUCCESS, @"支付成功");
                break;
                
            case WXPAYEXIT:   //用户退出支付
                
                self.IndexPayFailure(WXPAYEXIT, @"退出支付");
                break;
                
                
            default:        //剩余都是支付失败
                
                self.IndexPayFailure(WXPAYERROR, @"支付失败");
                break;
        }
    }
}



//支付宝支付回调方法 显示支付结果
- (void)ALiPayResultWithDict:(NSDictionary *)dict {
    
    NSInteger resultStatus = [dict[@"resultStatus"] integerValue];
    
    switch (resultStatus) {
        case ALIPAYSUCESS: //支付成功
            
            self.IndexPaySuccess(ALIPAYSUCESS, @"支付成功");
            break;
            
        case ALIPAYCANCEL:   //中途取消
            
            self.IndexPayFailure(ALIPAYCANCEL, @"中途取消");
            break;
        case ALIPAYNETError: //网络连接出错
            
            self.IndexPaySuccess(ALIPAYNETError, @"网络连接出错");
            break;
            
        case ALIPAYNDETAIL:   //处理中
            
            self.IndexPayFailure(ALIPAYNDETAIL, @"处理中");
            break;
            
        default:        //支付失败
            
            self.IndexPayFailure(ALIPAYERROR, @"支付失败");
            break;
    }
}





@end
