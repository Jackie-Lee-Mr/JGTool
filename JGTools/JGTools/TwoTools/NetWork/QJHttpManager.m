//
//  QJHttpManager.m
//  LH_QJ
//
//  Created by 郭军 on 2018/4/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJHttpManager.h"
#import "QJHttpModel.h"



@implementation QJHttpManager
//////////////////////////////////////////////////////////////////////////////////////
/*******************************  原生封装  *********************************************/
/**
 *  创建一个http请求
 *
 *  @param url        请求连接
 *  @param parameters 请求参数
 *  @param httpMthod  GET 或 POST
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)HttpRequestDataWithUrlString:(NSString *)url
                      Aarameters:(NSDictionary *)parameters
                       httpMthod:(QJHttpMthod)httpMthod
                         Success:(success)success
                         failure:(failure)failure {

    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    });
    
    if ([[parameters allKeys] containsObject:@"user_id"]) {
        NSString *user_id = parameters[@"user_id"];
        [QJCustomHUD hideHUD];
        
        if (!user_id.length) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                });
            });
            return;
        }
    }
    
    NSString *BaseUrl = [NSString stringWithFormat:@"%@/%@",HttpBaseUrl, url];
    
    NSString *UrlString;
    if (httpMthod == GET) { //处理请求url
        
        NSMutableString *mutableUrl = [[NSMutableString alloc] initWithString:BaseUrl];
        if ([parameters allKeys]) {
            [mutableUrl appendString:@"?"];
            for (id key in parameters) {
                NSString *value = [[parameters objectForKey:key] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                [mutableUrl appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
            }
        }
        UrlString = [[mutableUrl substringToIndex:mutableUrl.length - 1] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }else {
        
        UrlString = BaseUrl;
    }
    
    [self RequestDataWithUrlString:UrlString Aarameters:parameters httpMthod:httpMthod Success:success failure:failure];
}

/**
 *  处理请求头与请求体
 *
 *  @param url        请求连接
 *  @param parameters 请求参数
 *  @param httpMthod  GET 或 POST
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)RequestDataWithUrlString:(NSString *)url
                          Aarameters:(NSDictionary *)parameters
                           httpMthod:(QJHttpMthod)httpMthod
                             Success:(success)success
                             failure:(failure)failure {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSString *nonce = [NSString stringWithFormat:@"%06d", arc4random() % 100000];
    NSString *timestamp = [JGCommonTools currentTimeStr];
    NSString *user_id = QJUSER_ID;
    NSString *version = @"1";
    NSString *token = [JGCommonTools getUserDefaultsWithKey:@"token"];
    
    NSString *signStr;
    if (httpMthod == GET) { //处理请求头
        
         request.HTTPMethod = @"GET";
        NSMutableString *data1 = [NSMutableString string];
        for (NSString *key in parameters.allKeys) {
            
            [data1 appendFormat:@"%@%@",key,parameters[key]];
        }
        
        signStr  = [NSString stringWithFormat:@"%@%@%@%@%@%@",timestamp,nonce,user_id,version,token,data1];
    }else {  //处理请求头 请求体
        
        request.HTTPMethod = @"POST";
        NSString *jsonDict = [JGCommonTools convertToJsonData:parameters];
        signStr  = [NSString stringWithFormat:@"%@%@%@%@%@%@",timestamp,nonce,user_id,version,token,jsonDict];
        NSData *jsonData2 = [jsonDict dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPBody = jsonData2;
    }
    
    NSString *md5signStr = [[JGCommonTools md5String:signStr] uppercaseString];
    [request setValue:timestamp forHTTPHeaderField:@"timestamp"];
    [request setValue:user_id forHTTPHeaderField:@"used"];
    [request setValue:nonce forHTTPHeaderField:@"ne"];
    [request setValue:version forHTTPHeaderField:@"version"];
    [request setValue:md5signStr forHTTPHeaderField:@"sigture"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:20];
    
    [self RequestDataWithRequest:request Success:success failure:failure];
}

/**
 *  发送请求获取数据
 *
 *  @param request    请求
 *  @param success    成功回调
 *  @param failure    失败回调
 */
+ (void)RequestDataWithRequest:(NSMutableURLRequest *)request
                         Success:(success)success
                         failure:(failure)failure {

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!data) {
            [QJCustomHUD showError:@"网络请求失败"];
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        QJHttpModel *baseModel = [[QJHttpModel alloc] initWithObject:dict];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            });
        });
        
        
        if (baseModel.resultCode == QJResponseQuestion) { //需要重新登录
            
            [JGCommonTools saveToUserDefaults:@"" key:@"name"];
            [JGCommonTools saveToUserDefaults:@"" key:@"token"];
            [JGCommonTools saveToUserDefaults:@"" key:@"user_id"];
            [JGNotification postNotificationName:@"needShowLogin" object:nil];
        }
        
        switch (baseModel.resultCode) {
            case QJResponseSuccess:
                success(baseModel.data,baseModel.resultCode);
                break;
                
            default:
                failure(baseModel.resultCode,nil,baseModel.resultMessage);
                break;
        }
    }];
    [task resume];
}


@end
