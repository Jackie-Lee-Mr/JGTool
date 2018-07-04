//
//  QJHttpManager.h
//  LH_QJ
//
//  Created by 郭军 on 2018/4/17.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import <Foundation/Foundation.h>

//0-错误 1-正确 2-服务器内部错误 3-在其他地方登录或接口安全性问题（需要重新登录）
typedef enum : NSUInteger {
    QJResponseFailed = 0,
    QJResponseSuccess  = 1,
    QJResponseError   = 2,
    QJResponseQuestion   = 3,
    QJResponseUnknown,
} QJHttpResponseState;

typedef enum : NSUInteger {
    POST,
    GET,
} QJHttpMthod;


typedef void(^success)(id data, QJHttpResponseState responseState);
typedef void(^failure)(QJHttpResponseState responseState, NSError *error, NSString *message);



@interface QJHttpManager : NSObject

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
                             failure:(failure)failure;








@end
