//
//  JGCommonTools.h
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/20.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JGCommonTools : NSObject

#pragma mark - 计算行高 -
// 通过给定文字和字体大小在指定的最大宽度下，计算文字实际所占的尺寸
+ (CGSize)sizeForLblContent:(NSString *)strContent fixMaxWidth:(CGFloat)w andFondSize:(int)fontSize;

#pragma mark - 把格式化的JSON格式的字符串转换成字典 -
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


#pragma mark - 判断网络状态
+ (BOOL)isNetWorkReachable;


#pragma mark - 沙盒相关 -
// 往沙盒中存数据
+ (void)saveToUserDefaults:(id)object key:(NSString *)key;
//从沙盒中取数据
+ (id)getUserDefaultsWithKey:(NSString *)key;

#pragma mark - MD5加密 -
+ (NSString *)md5String:(NSString *)str;


#pragma mark - 采购 --> 根据值校验商品 返回商品信息 -
+ (NSString *)getPurchasesGoodsCheckInfoWithKey:(NSString *)key;

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;

#pragma mark - 窗口的跟控制器
+ (ZJBLTabbarController *)sharedZJBLTabbarController;


//时间戳转换日期
+ (NSString *)timeWithTimeIntervalString:(long )time;


//iOS 解决打电话反应慢的问题（换一种方式）
+ (void)callPhoneStr:(NSString*)phoneStr  withVC:(UIViewController *)selfvc;

@end
