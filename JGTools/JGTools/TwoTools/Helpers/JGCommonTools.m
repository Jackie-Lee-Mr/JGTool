//
//  JGCommonTools.m
//  ZJBL-SJ
//
//  Created by 郭军 on 2017/3/20.
//  Copyright © 2017年 ZJNY. All rights reserved.
//

#import "JGCommonTools.h"
#import <CommonCrypto/CommonDigest.h>
#import "QJAppDelegate.h"

@implementation JGCommonTools

#pragma mark -- 公共方法
#pragma mark -- 配置 视图 的属性【背景颜色】【圆角大小】【边线颜色】
+ (void)configPropertyWithView:(UIView *)view backgroundColor:(UIColor *)backgroundColor cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
{
    view.backgroundColor = backgroundColor;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = cornerRadius;
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
}

#pragma mark -- 配置任意圆角的方法
+ (void)configArbitraryCornerRadiusView:(UIView *)view cornerRadius:(CGFloat)cornerRadius withType:(ArbitraryCornerRadiusViewType)type
{
    UIBezierPath *maskPath = [[UIBezierPath alloc] init];
    switch (type) {
        case ArbitraryCornerRadiusViewTypeDefault:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRightBottomLeft:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftTopRightBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopLeftBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        case ArbitraryCornerRadiusViewTypeTopRightBottomLeftBottomRight:
        {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds            byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        }
            break;
        default:
            break;
    }
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

#pragma mark -- label 相关
#pragma mark -- 配置 label 的属性【字体】【颜色】【对齐方式】【显示行数】
+ (void)configPropertyWithLabel:(UILabel *)label font:(CGFloat)font textColor:(UIColor *)color textAlignment:(NSTextAlignment)textAlignment numberOfLine:(CGFloat)numberOfLine
{
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.numberOfLines = numberOfLine;
}

#pragma mark -- 配置 label 的属性【行间距】【要显示的最大宽度】
+ (void)configPropertyWithLabel:(UILabel *)label font:(CGFloat)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = size.height+1>font*2 ? lineSpace:0;
    NSRange range = NSMakeRange(0, [label.text length]);
    [attributedString addAttribute:NSBaselineOffsetAttributeName value:NSBaselineOffsetAttributeName range:range];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:range];
    label.attributedText = attributedString;
}

#pragma mark -- 计算带有行间距的 label 的高度
+ (CGFloat)getHeightWithLabel:(UILabel *)label font:(CGFloat)font lineSpace:(CGFloat)lineSpace maxWidth:(CGFloat)maxWidth
{
    CGFloat labelHeight = 0.0f;
    CGSize originSize = [label.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = originSize.height+1>font*2 ? lineSpace:0;
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font],
                          NSParagraphStyleAttributeName:paraStyle
                          ,NSBaselineOffsetAttributeName:NSBaselineOffsetAttributeName};
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    labelHeight = size.height+1;
    return labelHeight;
}

#pragma mark -- 计算文字单行显示的宽度
+ (CGFloat)getWidthWithLabel:(UILabel *)label font:(CGFloat)font
{
    // 当文字单行显示的时候 label 的高度
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, font) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size.width+1;
}

#pragma mark -- button 相关
#pragma mark -- 配置按钮的 【显示文字】 【字体颜色】 【字体大小】
+ (void)configPropertyWithButton:(UIButton *)button title:(NSString *)title titleColor:(UIColor *)titleColor titleLabelFont:(CGFloat)font
{
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
}
#pragma mark -- 配置按钮的背景图片
+ (void)configPropertyWithButton:(UIButton *)button normalBackgroundImage:(NSString *)normalBackgroundImage highlightBackgroundImage:(NSString *)highlightBackgroundImage
{
    [button setBackgroundImage:[UIImage imageNamed:normalBackgroundImage] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightBackgroundImage] forState:UIControlStateHighlighted];
}

#pragma mark -- textField 相关
+ (void)configPropertyWithTextField:(UITextField *)textField textFont:(CGFloat)textFont textColor:(UIColor *)textColor textPlaceHolder:(NSString *)placeHolder textPlaceHolderFont:(CGFloat)textPlaceHolderFont textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor textAlignment:(NSTextAlignment)textAlignment
{
    textField.font = [UIFont systemFontOfSize:textFont];
    textField.textColor = textColor;
    textField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeHolder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textPlaceHolderFont],NSForegroundColorAttributeName:textPlaceHolderTextColor}];
    textField.textAlignment = textAlignment;
}

#pragma mark -- textView 相关
+ (void)configPropertyWithTextView:(QJTextView *)textView textFont:(CGFloat)textFont textColor:(UIColor *)textColor lineSpace:(CGFloat)lineSpace textPlaceHolder:(NSString *)placeHolder textPlaceHolderFont:(CGFloat)textPlaceHolderFont textPlaceHolderTextColor:(UIColor *)textPlaceHolderTextColor textAlignment:(NSTextAlignment)textAlignment
{
    textView.font = [UIFont systemFontOfSize:textFont];
    textView.textColor = textColor;
    textView.textAlignment = textAlignment;
    textView.placeholder = placeHolder;
    textView.placeholderColor = textPlaceHolderTextColor;
    textView.placeholderFont = textPlaceHolderFont;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    textView.typingAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:textFont],NSParagraphStyleAttributeName:paragraphStyle};
}


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
 * @brief json格式字符串转数组
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+  (id)toArrayWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSError *err;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&err];
    if (jsonObject != nil && err == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
    
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

/*!
 * @brief 把字典转换成JSON
 * @param dict 字典
 * @return 返回JSON
 */
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        JGLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
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


+ (NSString *)get1970timeString{
    return [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970] * 1000];
}

//获取当前时间戳
+ (NSString *)currentTimeStr {
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

/**
 获取当前时间戳
 
 @return 当前时间戳
 */
+ (long )getCurrentTimeInterval {
    
    NSDate* datenow = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue];

    return timeSp;
}

+(long )getPriousorLaterDateFromDate:(long )timeStamp withMonth:(int)month{
    
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];// NSGregorianCalendar
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return [mDate timeIntervalSince1970];
}




//获取当前时间戳有两种方法(以秒为单位)

+(NSString *)getNowTimeTimestamp{
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
//    
//    //设置时区,这个对于时间的处理有时很重要
//
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
//
//    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
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
     JGLog("%02X", 0x888);  //888
     JGLog("%02X", 0x4); //04
     */
    return saveResult;
}

/**
 根据UIlabel的文字获取删除线
 
 @param LblText UIlabel上的文字
 @return 删除线
 */
+ (NSMutableAttributedString *)getDeleteLineWithString:(NSString *)LblText {
    
    NSUInteger length = [LblText length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:LblText];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:JG999Color range:NSMakeRange(0, length)];
    return attri;
}


/**
 从像素px转换为ios的点阵pt
 */
+(CGFloat)pxTopt:(CGFloat)pt{
//    CGFloat standardPt = px/2.0;
    if (iphone5) {
        pt = (iphone5W/iphone6W)*pt;
    }else if(iphone6){
        
    }else if(iphone6plus){
        pt = (iphone6plusW/iphone6W)*pt;
    }else;
    
    JGLog(@"从像素px转换为ios的点阵pt:%f",pt);
    
    return pt;
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
+ (QJBaseTabbarController *)sharedTabbarController {
    
    return (QJBaseTabbarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
}



//时间戳转换日期
+ (NSString *)timeWithTimeIntervalString:(long )time dateFormatter:(NSString *)formatter {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if (!formatter) {
        formatter = @"yyyy-MM-dd HH:mm:ss";
    }
    [dateFormatter setDateFormat:formatter];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
}


//请求下拉加载更多结束数据 提示语
+ (NSString *)TheEndOfTheData {
    return @"我是有底线的~";
}


//红包类型 10 购物鼓励金红包  11 拼手气鼓励金红包
//12 好友赠送红包 13 好友赠送红包  20 补贴卡
+ (NSString *)getTypeWithRedpacketType:(int)redpacket_type {
    if (redpacket_type == 20) {
        return @"补贴卡红包";
    }else if (redpacket_type == 10) {
        return @"购物鼓励金红包";
    }else if (redpacket_type == 11) {
        return @"拼手气鼓励金红包";
    }else if (redpacket_type == 12) {
        return @"好友赠送红包";
    }else if (redpacket_type == 13) {
        return @"好友赠送红包";
    }
    return @"红包";
}


/**
 通过银行卡名字获取银行卡图标
 
 @param bankTitle 银行卡名字
 @return 银行卡图标
 */
+ (NSString *)getBankIconWithBankName:(NSString *)bankTitle {
    
    if ([bankTitle isEqualToString:@"工商银行"]) {
         return @"bank1";
    }else if ([bankTitle isEqualToString:@"建设银行"]) {
         return @"bank2";
    }else if ([bankTitle isEqualToString:@"农业银行"]) {
         return @"bank3";
    }else if ([bankTitle isEqualToString:@"交通银行"]) {
         return @"bank4";
    }else if ([bankTitle isEqualToString:@"招商银行"]) {
         return @"bank5";
    }else if ([bankTitle isEqualToString:@"中国邮政"]) {
         return @"bank6";
    }else if ([bankTitle isEqualToString:@"中国银行"]) {
         return @"bank7";
    }else if ([bankTitle isEqualToString:@"华夏银行"]) {
         return @"bank8";
    }else if ([bankTitle isEqualToString:@"中信银行"]) {
         return @"bank9";
    }else if ([bankTitle isEqualToString:@"兴业银行"]) {
         return @"bank10";
    }else if ([bankTitle isEqualToString:@"光大银行"]) {
         return @"bank11";
    }else if ([bankTitle isEqualToString:@"民生银行"]) {
         return @"bank12";
    }else if ([bankTitle isEqualToString:@"广发银行"]) {
         return @"bank13";
    }else if ([bankTitle isEqualToString:@"浦发银行"]) {
         return @"bank14";
    }else if ([bankTitle isEqualToString:@"农村信用合作社"]) {
         return @"bank15";
    }
    
    return @"no";
}

+ (BOOL)isAllNum:(NSString *)string{
    unichar c;
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}



/** 根据图片二进制流获取图片格式 */
+ (NSString *)imageTypeWithData:(NSData *)data {
    uint8_t type;
    [data getBytes:&type length:1];
    switch (type) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}





#pragma mark - 网络监测 -
+ (BOOL)isNetWorkReachable {
    
    QJAppDelegate *appDelagate = (QJAppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelagate.isReachable == NO) {
        [QJCustomHUD showError:@"网络连接错误,请检查网络" ];
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
            
//            JGLog(@"点击了取消按钮");
        }]];
        [selfvc presentViewController:alert animated:YES completion:nil];
    }
}


@end
