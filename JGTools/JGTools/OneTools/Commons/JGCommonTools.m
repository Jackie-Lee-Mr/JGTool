//
//  JGCommonTools.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/20.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "JGCommonTools.h"
#import <CommonCrypto/CommonDigest.h>


@implementation JGCommonTools

// 通过给定文字和字体大小在指定的最大宽度下，计算文字实际所占的尺寸
+ (CGSize)sizeForLblContent:(NSString *)strContent fixMaxWidth:(CGFloat)w andFondSize:(int)fontSize{
    // 先获取文字的属性，特别是影响文字所占尺寸相关的
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 把该属性放到字典中
    NSDictionary *dicAttr = [[NSDictionary alloc] initWithObjectsAndKeys:font,NSFontAttributeName, nil];
    // 通过字符串的计算文字所占尺寸方法获取尺寸
    CGSize size = [strContent boundingRectWithSize:CGSizeMake(w, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicAttr context:nil].size;
    
    return size;
}


/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        JGLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}




// 往沙盒中存数据
+ (void)saveToUserDefaults:(id)object key:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        if (![object isKindOfClass:[NSArray class]]) {
            
            if ([object isKindOfClass:[NSNull class]]) {
                [standardUserDefaults setObject:@"" forKey:key];

            }else {
                [standardUserDefaults setObject:object forKey:key];

            }
            
        }
    }
    [standardUserDefaults synchronize];

}

//从沙盒中取数据
+ (id)getUserDefaultsWithKey:(NSString *)key
{
    id returnObj = nil;
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if (standardUserDefaults) {
        returnObj = [standardUserDefaults objectForKey: key];
    }
    return returnObj;
}


//MD5加密
+ (NSString *)md5String:(NSString *)str {
    //1.首先将字符串转换成UTF-8编码, 因为MD5加密是基于C语言的,所以要先把字符串转化成C语言的字符串
    const char *fooData = [str UTF8String];
    
    //2.然后创建一个字符串数组,接收MD5的值
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    
    //3.计算MD5的值, 这是官方封装好的加密方法:把我们输入的字符串转换成16进制的32位数,然后存储到result中
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    /**
     第一个参数:要加密的字符串
     第二个参数: 获取要加密字符串的长度
     第三个参数: 接收结果的数组
     */
    
    //4.创建一个字符串保存加密结果
    NSMutableString *saveResult = [NSMutableString string];
    
    //5.从result 数组中获取加密结果并放到 saveResult中
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
    return saveResult;
}

//采购 --> 根据值校验商品 返回商品信息
+ (NSString *)getPurchasesGoodsCheckInfoWithKey:(NSString *)key {
    
    NSString *resultStr;
    
    switch ([key intValue]) {
        case 0:
            break;
        case 1:
            resultStr = @"库存不足";
            break;
        case 2:
            resultStr = @"商品下架";
            break;
        case 3:
            resultStr = @"价格变动";
            break;
        case 4:
            resultStr = @"超出限购数";
            break;
        case 5:
            resultStr = @"活动已结束";
            break;
        default:
            resultStr = @"商品有问题";
            break;
    }
    return resultStr;
    
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}


#pragma mark - 窗口的跟控制器
+ (ZJBLTabbarController *)sharedZJBLTabbarController {
    
    return (ZJBLTabbarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}



//时间戳转换日期
+ (NSString *)timeWithTimeIntervalString:(long )time {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time/1000];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}


#pragma mark - 网络监测 -
+ (BOOL)isNetWorkReachable {
    
    ZJBLAppDelegate *appDelagate = (ZJBLAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelagate.isReachable == NO) {
//        [MBProgressHUD showError:@"网络连接错误,请检查网络"];
        return NO;
    }
    return YES;
}


//iOS 解决打电话反应慢的问题（换一种方式）
+ (void)callPhoneStr:(NSString*)phoneStr  withVC:(UIViewController *)selfvc {
    
    NSString *str2 = [[UIDevice currentDevice] systemVersion];
    
    if ([str2 compare:@"10.2"options:NSNumericSearch] == NSOrderedDescending || [str2 compare:@"10.2"options:NSNumericSearch] == NSOrderedSame) {
        
//        JGLog(@">=10.2");
        
        NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
        
        if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
            
            UIApplication * app = [UIApplication sharedApplication];
            if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
                
                [app openURL:[NSURL URLWithString:PhoneStr]];
            }
        }
    }else {
        
        NSMutableString* str1 = [[NSMutableString alloc]initWithString:phoneStr];// 存在堆区，可变字符串
        
        if (phoneStr.length == 10) {
            
            [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
            [str1 insertString:@"-"atIndex:7];// 把一个字符串插入另一个字符串中的某一个位置
        }else {
            
            [str1 insertString:@"-"atIndex:3];// 把一个字符串插入另一个字符串中的某一个位置
            [str1 insertString:@"-"atIndex:8];// 把一个字符串插入另一个字符串中的某一个位置
        }
        
        NSString * str = [NSString stringWithFormat:@"是否拨打电话\n%@",str1];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message: nil preferredStyle:UIAlertControllerStyleAlert];
        
        // 设置popover指向的item
        alert.popoverPresentationController.barButtonItem = selfvc.navigationItem.leftBarButtonItem;
        
        // 添加按钮
        
        [alert addAction:[UIAlertAction actionWithTitle:@"呼叫"style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
//            JGLog(@"点击了呼叫按钮10.2下");
            
            NSString* PhoneStr = [NSString stringWithFormat:@"tel://%@",phoneStr];
            
            if ([PhoneStr hasPrefix:@"sms:"] || [PhoneStr hasPrefix:@"tel:"]) {
                
                UIApplication * app = [UIApplication sharedApplication];
                if ([app canOpenURL:[NSURL URLWithString:PhoneStr]]) {
                    
                    [app openURL:[NSURL URLWithString:PhoneStr]];
                }
            }
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            
            JGLog(@"点击了取消按钮");
        }]];
        [selfvc presentViewController:alert animated:YES completion:nil];
    }
}


@end
