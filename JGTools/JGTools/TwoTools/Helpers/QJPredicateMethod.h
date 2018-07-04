//
//  QJPredicateMethod.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/21.
//  Copyright © 2018年 LHYD. All rights reserved.
//  正则表达式部分

#import <Foundation/Foundation.h>

@interface QJPredicateMethod : NSObject

#pragma 匹配手机号
+ (BOOL) isValidateMobile:(NSString *)mobile;

#pragma 匹配手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

#pragma 匹配密码
+ (BOOL)validatePassword:(NSString *)passWord;

#pragma 匹配verifyCode
+ (BOOL) validateVerifyCode: (NSString *)verifyCode;

#pragma 匹配邮箱
+ (BOOL) validateEmail:(NSString *)email;

#pragma 匹配身份证号码校验
+ (BOOL)isIdCardNumber:(NSString *)value;

#pragma 匹配用户名
+ (BOOL)validateUserName:(NSString *)name;

#pragma 匹配昵称
+ (BOOL)validateNickname:(NSString *)nickname;

#pragma 匹配身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

#pragma 匹配银行卡
+ (BOOL)validateBankCardNumber: (NSString *)bankCardNumber;

#pragma 匹配银行卡后四位
+ (BOOL)validateBankCardLastNumber: (NSString *)bankCardNumber;

#pragma 匹配 判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;
@end
